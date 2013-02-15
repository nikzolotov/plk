$(function(){
    $('.b-moving-car').movingCar();
    $('.b-scroll-gallery').scrollGallery();
    $('#external_content .b-main-navigation').parallaxScroll();
    $('#external_content .b-main-navigation, .b-navigation-deployed').smoothScrolling();
    
    $('.b-calculation-cost').calculationPayment();
    $('.b-events .item').toggleLink(); 
});










/* Plugins */

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
			containerCurrency: '.field-currencies',
			containerAdvance: '.field-advance',
			containerYears: '.field-years',
			sliders: '.movement',
			inputs: '.input-slider',
			range: 'min',
			orientationSlider: "horizontal",
            valueCurrency: [100000, 10000000],
            valueAdvance: [0, 100],
            valueMonth: [12, 48],
            calculation: '.b-calculation',
            valueCalculation: '.b-calculation .number',
            currencies: '.currencies .link',
            selectedCurrency: 'selected',
            symbolCurrencies: '.currency, .field-currencies .sign',
            selectedCurrencyContent: '.currencies .selected',
            numbers: '.b-movement .number',
            category: '.field-currencies .category'
        };
        return this.each(function(){
        	if(userOptions) {
		        $.extend( OPTIONS, userOptions );
		    }

        	var container = $(this),
        		sliders = $(OPTIONS.sliders, container),
        		inputs = $(OPTIONS.inputs, container),

        		sliderCurrency = $(OPTIONS.containerCurrency, container).find(OPTIONS.sliders),
        		inputCurrency = $(OPTIONS.containerCurrency, container).find(OPTIONS.inputs),
        		sliderAdvance = $(OPTIONS.containerAdvance, container).find(OPTIONS.sliders),
        		inputAdvance = $(OPTIONS.containerAdvance, container).find(OPTIONS.inputs),
        		sliderYears = $(OPTIONS.containerYears, container).find(OPTIONS.sliders),
        		inputYears = $(OPTIONS.containerYears, container).find(OPTIONS.inputs),

        		calculation = $(OPTIONS.calculation, container),
        		valueCalculation = $(OPTIONS.valueCalculation, container),
        		currencies = $(OPTIONS.currencies, container),
        		symbolCurrencies = $(OPTIONS.symbolCurrencies, container),
        		selectedCurrencyContent = $(OPTIONS.selectedCurrencyContent, container),
        		valueSC = selectedCurrencyContent.text(),
        		category = $(OPTIONS.category, container)
	
				exchange = {
					'РУБ': 1,
        			'USD': 30,
        			'EUR': 40
				},
        		rubsArray = [100000, 500000, 1000000, 10000000],
        		numbers = $(OPTIONS.numbers),
        		valueCurrencies = {
        			'РУБ': rubsArray,
        			'USD': $.map(rubsArray,function(n, i){return n/exchange['USD'];}),
        			'EUR': $.map(rubsArray,function(n, i){return n/exchange['EUR'];})
        		},
        		currencyLetters = {
        			'РУБ': 'р',
        			'USD': '$',
        			'EUR': '€'
        		},
        		reduction = {
        			'РУБ': 'rub',
        			'USD': 'usd',
        			'EUR': 'eur'
        		},
        		_replaseSeparator = /(\d)(?=(\d\d\d)+([^\d]|$))/g;

        	inputs.val('');
        	changeCurrency();
        	changeSliders();
        	workingCalculation();
        	runChangeCurrency();

        	function changeSliders(){
        		/* Run slider_ui for different sliders */
        		runSlider(sliderCurrency, OPTIONS.valueCurrency[0], OPTIONS.valueCurrency[1], inputCurrency, true);
        		runSlider(sliderAdvance, OPTIONS.valueAdvance[0], OPTIONS.valueAdvance[1], inputAdvance, false);
        		runSlider(sliderYears, OPTIONS.valueMonth[0], OPTIONS.valueMonth[1], inputYears, false);
        		
        	}

        	function runSlider(selector, _min, _max, input, formatting){

        		selector.slider({
			        orientation: OPTIONS.orientationSlider,
			        range: OPTIONS.range,
			        min: _min,
			        max: _max,
			        value: 0,
			        slide: function( event, ui ) {
			        	var uiValue = ui.value;

			        	if(formatting){
			        		uiValue = Math.round(ui.value / exchange[valueSC])
			        		uiValue = replase(uiValue);
			        	}
			        	
			        	input.val(uiValue);
			        	workingCalculation();
			        }
			    });
			    
			    input.change(function() {
			    	inputValue = $(this).val();

			    	if(formatting) {
			    		inputValue = parseInt(inputValue.replace(/\s+/g, ''));
			    		inputValue = Math.round(inputValue*exchange[valueSC]);
			    	}
			    	
			    	selector.slider( "value", inputValue);
			    	workingCalculation();
			    });

			    input.focusout(function(){
			    	_this = $(this);
			    	_this.val(replase(_this.val()));
			    })

        	}

        	function replase(value){
        		value += ''; 

        		return value.replace(_replaseSeparator, '$1 ');
        	}

        	function workingCalculation(){
        		valueCurrency = parseInt(inputCurrency.val().replace(/\s+/g, '')),
        		valueAdvance = inputAdvance.val(),
        		valueMonth = inputYears.val();

				if(valueCurrency == '' || valueAdvance == '' || valueMonth == '') calculation.hide();
				else calculation.show();

				if(valueCurrency >= 0 && valueAdvance >= 0 && valueMonth > 0)
					valueCalculation.text(replase(Math.round(( valueCurrency*(1 - valueAdvance/100) )/valueMonth)));
			}

			function changeCurrency(){
				numbers.each(function(index, element){ 
					installNumbers($(element), valueCurrencies[valueSC], index);
				});

				symbolCurrencies.text(currencyLetters[valueSC]);
				category.removeAttr('class').addClass('category').addClass('category-'+reduction[valueSC]);

				inputCurrency.val('');
				runSlider(sliderCurrency, OPTIONS.valueCurrency[0], OPTIONS.valueCurrency[1], inputCurrency, true);
			}


			function installNumbers(element, array, index){
				element.text(replase(Math.round(array[index])));
			}


			function runChangeCurrency(){
				currencies.click(function(event){
					selectedCurrencyContent = $(this),
					valueSC = selectedCurrencyContent.text();

					currencies.removeClass(OPTIONS.selectedCurrency);
					selectedCurrencyContent.addClass(OPTIONS.selectedCurrency);
					
					changeCurrency();
					calculation.hide();

					event.preventDefault();
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








