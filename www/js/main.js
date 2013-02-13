$(function(){
    $('.b-moving-car').movingCar();
    $('#external_content .b-main-navigation').parallaxScroll();
    $('#external_content .b-main-navigation, .b-navigation-deployed').smoothScrolling();
    $('.b-scroll-gallery').scrollGallery();
    
    $( ".b-movement .movement" ).slider({
        orientation: "horizontal",
        range: "min",
        max: 255,
        value: 0
    });
    $('.b-calculation-cost').calculationPayment();
    $('.b-events .item').toggleLink();

    
});












(function( $ ){
	$.fn.toggleLink = function(userOptions) {
		var OPTIONS = {
             subContent: '.sub-content',
             links: '.link',
             selectedClass: 'item-selected',
             commonContainer: ''
        };
        return this.each(function(){
        	if(userOptions) {
		        $.extend( OPTIONS, userOptions );
		    }
		    var container = $(this),
		    	subContent = $(OPTIONS.subContent,container),
		    	links = $(OPTIONS.links,container);

		    links.data('selected', false);

		    links.click(function(event){
		    	if(!links.data('selected')){
		    		container.addClass(OPTIONS.selectedClass);
		    		links.data('selected', true);
		    		subContent.slideDown(100);
		    	}
		    	else {
		    		subContent.slideUp(100,function(){
		    			container.removeClass(OPTIONS.selectedClass);
		    		});
		    		links.data('selected', false);
		    	}
		    	event.preventDefault();
		    });
        	
        });
     };

	$.fn.calculationPayment = function(userOptions) {
		var OPTIONS = {
             linksCurrencies: '.currencies .link',
             selectedCurrency: 'selected',
             changeСurrency: '.field-currencies .currency, .b-field-sign .sign, .b-calculation .currency',
             inputCurrency: '.field-currencies input',
             inputAdvance: '.field-advance input',
             inputYears: '.field-years input',
             calculation: '.b-calculation',
             valueNumber: '.b-calculation .number'
        };
        return this.each(function(){
        	if(userOptions) {
		        $.extend( OPTIONS, userOptions );
		    }

        	var container = $(this),
        		linksCurrencies = $(OPTIONS.linksCurrencies,container),
        		changeСurrency = $(OPTIONS.changeСurrency,container),
        		inputCurrency = $(OPTIONS.inputCurrency,container),
        		inputAdvance = $(OPTIONS.inputAdvance,container),
        		inputYears = $(OPTIONS.inputYears,container),
        		valueNumber = $(OPTIONS.valueNumber,container),
        		calculation = $(OPTIONS.calculation,container),
        		currency = 'р.';

        	eventClickCurrency();
        	changeCurrency();
        	manageInput();
        	toggleCalculation();
        	changeInput();

			function eventClickCurrency(){
				linksCurrencies.click(function(event){
					_this = $(this);

					linksCurrencies.removeClass(OPTIONS.selectedCurrency);
					_this.addClass(OPTIONS.selectedCurrency)

					changeCurrency();

					event.preventDefault();
				});
			}
			function changeCurrency() {
				value = linksCurrencies.filter('.'+OPTIONS.selectedCurrency).find('.text').text();

				if(value == 'РУБ') currency = 'р';
				if(value == 'USD') currency = '$';
				if(value == 'EUR') currency = '€';

				changeСurrency.text(currency);
			}
			function manageInput(){
				inputCurrency.add(inputAdvance).add(inputYears).val('');
				valueNumber.text('')
			}
			function toggleCalculation(){
				if(inputCurrency.val() == '' || inputAdvance.val() == '' || inputYears.val() == '') calculation.hide();
				else calculation.show();
			}
			function changeInput(){
				inputCurrency.add(inputAdvance).add(inputYears).change(function(){
					var _this = $(this),
						field = _this.parents('.field');
					if(isNaN(_this.val())) _this.val('');
					else {
						var ui_range = field.find('.ui-slider-range'),
							ui_handle = field.find('.ui-slider-handle'),
							value = _this.val();
						if(field.hasClass('field-advance')){
							if(value < 0) _this.val(0)
							else if(value > 100) _this.val(100)
							value = _this.val();
							ui_handle.css('left',value+'%')
							ui_range.css('width',value+'%')
						}
						if(field.hasClass('field-years')){
							if(value < 1) _this.val(1)
							
							value = (12*_this.val() - 1.2 - 11.376)/0.39;
							if(_this.val() > 4) {
								value = 100;
							}

							ui_handle.css('left',value+'%')
							ui_range.css('width',value+'%')
						}
						if(field.hasClass('field-currencies')){
							if(value < 100000) _this.val(100000)
							
							value = Math.round(21.811*Math.log(_this.val())/Math.log(2.71828182) - 250.28);
							
							if(_this.val() > 13564700) value = 100;
							if(_this.val() == 100000) value = 0;

							ui_handle.css('left',value+'%')
							ui_range.css('width',value+'%')
						}
					}
					toggleCalculation();
				});
			}
        });
     };

	$.fn.movingCar = function(userOptions) {
		var OPTIONS = {
             car: '.car',
             top: 1000,
             bottom: 1700
        };
        return this.each(function(){
        	if(userOptions) {
		        $.extend( OPTIONS, userOptions );
		    }
        	var car = $(OPTIONS.car),
				x_car = car.css('left'),
				y_car = car.css('top'),
				new_x_car = 0,
				new_y_car = 0,
				scrolled_top = $(window).scrollTop();

			$(window).bind('scroll',function(event){
				scrolled_top = $(this).scrollTop()
				drivingCar(scrolled_top);
			});
        	
        	function drivingCar(){
        		if((scrolled_top >= OPTIONS.top || new_x_car > 0) && scrolled_top <= OPTIONS.bottom){
					new_x_car = parseInt(x_car)+(scrolled_top-OPTIONS.top)*2;
					if(new_x_car < 0) new_x_car = 0;
					if(new_x_car >= 239) new_y_car = 0.0003*new_x_car*new_x_car-0.1453*new_x_car+19.817;
					else new_y_car = -19;
					car.animate({
						top: (-new_y_car)+'px',
						left: new_x_car+'px'
					},{
						queue: false
						}
					);
					if(new_x_car > 0)car.css('transform','rotate('+(-Math.round(new_x_car/58))+'deg)');
					
				}
        	}
        });
     };
     $.fn.parallaxScroll = function(userOptions) {
		var OPTIONS = {
             main_section: '#main_section',
             about_company: '#about',
             special_achinery: '#special-technics',
             motor_transport: '#motor-vehicles',
             equipment: '#equipment',
             request: '#request',
             links: '.item .link, .item-request .link',
             external_content: '#external_content',
             all_links: '.link'
        };
        return this.each(function(){
        	if(userOptions) {
		        $.extend( OPTIONS, userOptions );
		    }
        	var main_section = $(OPTIONS.main_section),
        		about_company = $(OPTIONS.about_company),
        		special_achinery = $(OPTIONS.special_achinery),
        		motor_transport = $(OPTIONS.motor_transport),
        		equipment = $(OPTIONS.equipment),
        		request = $(OPTIONS.request),
        		container = $(this),
        		external_content = $(OPTIONS.external_content),
				distance_ex_cont =parseInt(external_content.css('marginTop')),
				scrolled_top = $(window).scrollTop(),
				links = $(OPTIONS.links, container),
				all_links = $(OPTIONS.all_links, container);

				all_links.filter('[href*=#about]').data('selected',false);
				all_links.filter('[href*=#special-technics]').data('selected',false);
				all_links.filter('[href*=#motor-vehicles]').data('selected',false);
				all_links.filter('[href*=#equipment]').data('selected',false);
				all_links.filter('[href*=#request]').data('selected',false);


			var height_main_section = main_section.height(),
				height_about_company = about_company.height(),
				height_special_achinery = special_achinery.height(),
				height_motor_transport = motor_transport.height(),
				height_equipment = equipment.height(),
				height_request = request.height();


			parallaxScroll(scrolled_top);
			$(window).bind('scroll',function(event){
				scrolled_top = $(this).scrollTop()
				parallaxScroll(scrolled_top);
			});

			function  parallaxScroll(scrolled_top){
				var external_content_top = distance_ex_cont - scrolled_top;
				if(external_content_top >= 0)
					external_content.css('marginTop',external_content_top+'px');
				else
					external_content.css('marginTop','0px');

				/* Main section */
				if(scrolled_top >= 0 && scrolled_top <= height_main_section){
					main_section.css('background-position','50% '+(-scrolled_top*0.2)+'px')
				}

				/* About company */
				_top = height_main_section - 1000;
				_bottom = height_main_section+height_about_company;
				if(scrolled_top >= _top && scrolled_top <= _bottom){
					about_company.css('background-position','50% '+(-(scrolled_top-_top)*0.2)+'px')
				}
				activationMenu(scrolled_top,OPTIONS.about_company, _bottom-(height_about_company+300), _bottom-300);

				/* Special achinery */
				_top = _bottom - 1000;
				_bottom += height_special_achinery;
				if(scrolled_top >= _top && scrolled_top <= _bottom){
					special_achinery.css('background-position','50% '+(-(scrolled_top-_top)*0.2)+'px')
				}
				activationMenu(scrolled_top,OPTIONS.special_achinery, _bottom-(height_special_achinery+301), _bottom-300);

				/* Motor transport */
				_top = _bottom - 1000;
				_bottom += height_motor_transport;
				if(scrolled_top >= _top && scrolled_top <= _bottom){
					motor_transport.css('background-position','50% '+(-(scrolled_top-_top)*0.2)+'px')
				}
				activationMenu(scrolled_top,OPTIONS.motor_transport, _bottom-(height_motor_transport+301), _bottom-300);

				/* Equement */
				_top = _bottom - 1000;
				_bottom += height_equipment;
				if(scrolled_top >= _top && scrolled_top <= _bottom){
					equipment.css('background-position','50% '+(-(scrolled_top-_top)*0.2)+'px')
				}
				activationMenu(scrolled_top,OPTIONS.equipment, _bottom-(height_equipment+301), _bottom-400);

				/* Request */
				_top = _bottom - 900;
				_bottom += height_request;
				if(scrolled_top >= _top && scrolled_top <= _bottom){
					request.css('background-position','50% '+(-(scrolled_top-_top)*0.2)+'px')
				}
				activationMenu(scrolled_top,OPTIONS.request, _bottom-(height_request+401), _bottom);
			}

			function activationMenu(scrolled_top,link,start,end){
				link = all_links.filter('[href*='+link+']')
				if(scrolled_top >= start && scrolled_top <= end){
					if(!link.data('selected')){
						links.removeClass('link-active')
						link.addClass('link-active').data('selected',true);
					}
				}
				else{
					link.removeClass('link-active')
					link.data('selected',false)
				}
			}
	
        });
     };

     $.fn.smoothScrolling = function(userOptions) {
		var OPTIONS = {
             all_links: '.link',
             animateTime: 700
        };
        return this.each(function(){
        	if(userOptions) {
		        $.extend( OPTIONS, userOptions );
		    }
        	var container = $(this),
				all_links = $(OPTIONS.all_links, container);

			smoothScrolling();
			
			function smoothScrolling(){
				all_links.click(function (event) { 
				    elementClick = $(this).attr("href");
				    destination = $(elementClick).offset().top;
				    if($.browser.safari || $.browser.webkit) $('body').animate( { scrollTop: destination }, OPTIONS.animateTime );
				    else $('html').animate( { scrollTop: destination }, OPTIONS.animateTime );

				    event.preventDefault();
			    });
			}
	
        });
     };

})( jQuery );








