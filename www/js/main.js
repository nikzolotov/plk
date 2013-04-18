$(function(){
    $('.b-moving-car').movingCar();
    $('.b-scroll-gallery').scrollGallery();
    $('#external_content .b-main-navigation').parallaxScroll();
    $('#external_content .b-main-navigation, .b-navigation-deployed, .b-modal-calculation .submit').smoothScrolling();
    
    $('.b-calculation-cost').calculationPayment();
    $('.b-events .item').toggleLink();





    /* Форма обратной связи */
    var requestForm = $('#request_form');

    var requestContainer = $('.b-request'),
		requestInputs = $('input[type=text], textarea', requestForm),
		requestSubmit = $('input[type=submit]', requestForm);

    if(requestForm.length > 0){
      requestForm.validate({
      	submitHandler: function(form) {
  			$.ajax({
  			  	type: 'post',
  				url: 'request_form.html',
  				data: requestForm.serializeArray(),
  				dataType: 'html',
  				success: function(response){
  				    if( typeof response === 'string' ){
  				     	requestContainer.hide().after(response);
  				    }
  			    }
  			});
  		}
      });
      independentToggle.init();   
    }

    var switchPhone = $('.b-switch-phone'),
        items = $('.item', switchPhone),
        links = $('.link', switchPhone),
        itemPhone = $('.item-phones', switchPhone);
    installPhone(links.filter('.selected').find('.phone').text())
    links.click(function(event){
      var _this = $(this);
      if(!_this.hasClass('selected')){
        installPhone(_this.find('.phone').text());
        links.removeClass('selected');
        _this.addClass('selected');
      }
      event.preventDefault();
    });
    function installPhone(phone){
      itemPhone.text(phone);
    }

    $('.b-wrapped-line').switchConditions();
    
});










/* Plugins */
var independentToggle = (function(){
	var OPTIONS = {
         hideningContent: '.b-zigzag-design',
         showwingContent: '.b-main-navigation'
    };

    var hideningContent, showwingContent, topHidenningContent;


    function generateScroll(){
    	var scrollTop = $(window).scrollTop();

    	toggleShowwingContent(scrollTop);


    	$(window).bind('scroll',function(event){
			scrollTop = $(this).scrollTop()
			toggleShowwingContent(scrollTop);
		});
    }

    function toggleShowwingContent(scrollTop){
    	if(scrollTop > topHidenningContent)
    		showwingContent.fadeIn(200);
    	else
    		showwingContent.fadeOut(200);
    }

    return {
    	init: function( userOptions ){
			$.extend(OPTIONS, userOptions);

			hideningContent = $(OPTIONS.hideningContent),
    		showwingContent = $(OPTIONS.showwingContent),

    		topHidenningContent = hideningContent.offset().top + hideningContent.height();

    		showwingContent.hide();

			generateScroll();
		}
	}
})();




(function( $ ){

  $.fn.switchConditions = function(userOptions) {
    var OPTIONS = {
             linkActive: '.title .link',
             content: '.content'
        };
        return this.each(function(){
          if(userOptions) {
            $.extend( OPTIONS, userOptions );
          }
          var container = $(this),
              content = $(OPTIONS.content,container),
              links = $(OPTIONS.linkActive,container);

          links.data('selected', false);

          links.click(function(event){
            if(!links.data('selected')){
              links.data('selected', true);
              content.slideDown(100);
            }
            else {
              content.slideUp(100);
              links.data('selected', false);
            }
            event.preventDefault();
          });
          
        });
     };


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

	$.fn.calculationPayment = function(userOptions){
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
      valueCalculation: '.b-calculation .calc-month .number',
      valueTotalCalculation: '.b-calculation .calc-total .number',
      currencies: '.currencies .link',
      selectedCurrency: 'selected',
      symbolCurrencies: '.currency, .field-currencies .sign',
      selectedCurrencyContent: '.currencies .selected',
      numbers: '.b-movement .number',
      category: '.field-currencies .category',
      categoryLeasedAsset: '#category'
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
        valueTotalCalculation = $(OPTIONS.valueTotalCalculation, container),
    		currencies = $(OPTIONS.currencies, container),
    		symbolCurrencies = $(OPTIONS.symbolCurrencies, container),
    		selectedCurrencyContent = $(OPTIONS.selectedCurrencyContent, container),
        categoryLeasedAsset = $(OPTIONS.categoryLeasedAsset),
    		valueSC = 'RUB',
    		category = $(OPTIONS.category, container),

        valueCategoryPS = {
          'motor_transport': [0.17, 0.20],
          'special': [0.17, 0.21],
          'equipment': [0.19, 0.22]
        }

  		  exchange = {
  		    'RUB': 1,
    			'USD': 30,
    			'EUR': 40
  		  },
    		rubsArray = [100000, 500000, 1000000, 10000000],
    		numbers = $(OPTIONS.numbers),
    		valueCurrencies = {
    			'RUB': rubsArray,
    			'USD': $.map(rubsArray,function(n, i){return n/exchange['USD'];}),
    			'EUR': $.map(rubsArray,function(n, i){return n/exchange['EUR'];})
    		},
    		currencyLetters = {
    			'RUB': 'р',
    			'USD': '$',
    			'EUR': '€'
    		},
    		reduction = {
    			'RUB': 'rub',
    			'USD': 'usd',
    			'EUR': 'eur'
    		},
    		_replaseSeparator = /(\d)(?=(\d\d\d)+([^\d]|$))/g;

      	settingVar(selectedCurrencyContent.find('.text'))

      	inputs.val('');
      	changeCurrency();
      	changeSliders();
      	workingCalculation();
      	runChangeCurrency();

        categoryLeasedAsset.change(function() {
           workingCalculation();
        });

      	function settingVar(_text){
      		if(_text.hasClass('text-rub')) valueSC = 'RUB';
      		else if(_text.hasClass('text-usd')) valueSC = 'USD';
      		else if(_text.hasClass('text-euro')) valueSC = 'EUR';
      	}

      	function changeSliders(){
      		/* Run slider_ui for different sliders */
      		runSlider(sliderCurrency, OPTIONS.valueCurrency[0], OPTIONS.valueCurrency[1], inputCurrency, true, false);
      		runSlider(sliderAdvance, OPTIONS.valueAdvance[0], OPTIONS.valueAdvance[1], inputAdvance, false, false);
      		runSlider(sliderYears, OPTIONS.valueMonth[0], OPTIONS.valueMonth[1], inputYears, false, false);
      		
      	}

        function runSlider(selector, _min, _max, input, formatting, changeVar){
      		selector.slider({
  	        orientation: OPTIONS.orientationSlider,
  	        range: OPTIONS.range,
  	        min: _min,
  	        max: _max,
  	        slide: function( event, ui ) {
  	        	var uiValue = ui.value;

  	        	if(formatting){
  	        		uiValue = Math.round(ui.value / exchange[valueSC])
  	        		uiValue = replase(uiValue);
  	        	}
  	        	input.removeClass('error');
  	        	input.val(uiValue);
  	        	workingCalculation();
  	        }
  	      });

      		if(changeVar && input.val() != '') {
      			value = selector.slider( "value");
      			value = Math.round(value/exchange[valueSC]);
      			input.val(replase(value));
      		}
  		    
  		    input.change(function() {
  		    	inputValue = $(this).val();

  		    	if(formatting && inputValue != '') {
  		    		inputValue = parseInt(inputValue.replace(/\s+/g, ''));
  		    		inputValue = Math.round(inputValue*exchange[valueSC]);
  		    	}
  		    	
  		    	selector.slider( "value", inputValue);
  		    	workingCalculation();
  		    });



  		    input.focusout(function(){
  		    	_this = $(this);
  		    	_this.val(replase(_this.val()));
  		    });

        }

        function replase(value){
      		value += ''; 
      		return value.replace(_replaseSeparator, '$1 ');
        }

        function workingCalculation(){
      		valueCurrency = parseInt(inputCurrency.val().replace(/\s+/g, '')),
      		valueAdvance = inputAdvance.val(),
      		valueMonth = inputYears.val(),
          valuePSFirst = valueCategoryPS[categoryLeasedAsset.val()][0],
          valuePSSecond = valueCategoryPS[categoryLeasedAsset.val()][1];
          
  				if(valueCurrency == '' || valueAdvance == '' || valueMonth == '') calculation.hide();
  				else calculation.show();

  				if(valueCurrency >= 0 && valueAdvance >= 0 && valueMonth > 0){
            S = valueCurrency*(1-valueAdvance/100)
            PFirst = valuePSFirst*1.18/12;
            PSecond = valuePSSecond*1.18/12;
  					valueFirst = S*(PFirst+PFirst/((Math.pow((1+PFirst), valueMonth))-1));
            valueSecond = S*(PSecond+PSecond/((Math.pow((1+PSecond), valueMonth))-1));
  					valueCalculation.text(replase(Math.round(valueFirst))+'-'+replase(Math.round(valueSecond)));
            valueTotalCalculation.text(replase(Math.round(valueCurrency*valueAdvance/100 + valueFirst*valueMonth))+'-'+replase(Math.round(valueCurrency*valueAdvance/100 + valueSecond*valueMonth)))
  				}
  			}

  			function changeCurrency(){
  				numbers.each(function(index, element){ 
  					installNumbers($(element), valueCurrencies[valueSC], index);
  				});

  				symbolCurrencies.text(currencyLetters[valueSC]);
  				category.removeAttr('class').addClass('category').addClass('category-'+reduction[valueSC]);

  				
  				runSlider(sliderCurrency, OPTIONS.valueCurrency[0], OPTIONS.valueCurrency[1], inputCurrency, true, true);
  			}


  			function installNumbers(element, array, index){
  				element.text(replase(Math.round(array[index])));
  			}


  			function runChangeCurrency(){
  				currencies.click(function(event){
  					selectedCurrencyContent = $(this),
  					settingVar(selectedCurrencyContent.find('.text'));

  					currencies.removeClass(OPTIONS.selectedCurrency);
  					selectedCurrencyContent.addClass(OPTIONS.selectedCurrency);
  					
  					changeCurrency();
  					workingCalculation();

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
               external_selector: '#external_content',
               external_content: '#external_content .b-mini-logo, #external_content .b-main-navigation',
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
          		external_selector = $(OPTIONS.external_selector),
  				distance_ex_cont = 1170,
  				scrolled_top = $(window).scrollTop(),
  				links = $(OPTIONS.links, container),
  				all_links = $(OPTIONS.all_links, container),
  				gallery = $('.b-scroll-gallery');

  				all_links.filter('[href*=#about]').data('selected',false);
  				all_links.filter('[href*=#special-technics]').data('selected',false);
  				all_links.filter('[href*=#motor-vehicles]').data('selected',false);
  				all_links.filter('[href*=#equipment]').data('selected',false);
  				all_links.filter('[href*=#request]').data('selected',false);


  			var height_about_company = about_company.height(),
  				height_special_achinery = special_achinery.height(),
  				height_motor_transport = motor_transport.height(),
  				height_equipment = equipment.height(),
  				height_request = request.height();


        var linksLine = $('.b-wrapped-line .title .link');

        
  			/* bg */
  			external_selector.data('value_bg','brown-gr');

        
        var colorPhone = '#919191';

        /* Switch phone */
        var switchPhone = $('.b-switch-phone'),
            links = $('.link', switchPhone);
        links.click(function(event){
          var _this = $(this);
          if(!_this.hasClass('selected')){
            links.removeAttr('style');
            _this.css('background',colorPhone);
          }
          event.preventDefault();
        });

  			parallaxScroll(scrolled_top);
  			$(window).bind('scroll',function(event){
  				scrolled_top = $(this).scrollTop()
  				parallaxScroll(scrolled_top);
  			});

  			function  parallaxScroll(scrolled_top){
          height_special_achinery = special_achinery.height();
          height_motor_transport = motor_transport.height();
          height_equipment = equipment.height();

  				var external_content_top = distance_ex_cont - scrolled_top;
  				if(external_content_top >= 0)
  					external_content.css('marginTop',external_content_top+'px');
  				else
  					external_content.css('marginTop','0px');

  				/* About company */
  				if(scrolled_top >= 0 && scrolled_top <= height_about_company){
  					//if(!gallery.hasClass('b-scroll-gallery-fixed'))
  						about_company.css('background-position','50% '+(-(scrolled_top)*0.2)+'px')
  				}
  				activationMenu(scrolled_top,OPTIONS.about_company, 0, height_about_company-300);
  				changeBg(scrolled_top, 'brown-gr', 0, height_about_company+30, '#919191');

  				/* Special achinery */
  				_top = height_about_company - 1000;
  				_bottom = height_about_company+height_special_achinery;
  				if(scrolled_top >= _top && scrolled_top <= _bottom){
  					special_achinery.css('background-position','50% '+(-(scrolled_top-_top)*0.2)+'px')
  				}
  				activationMenu(scrolled_top,OPTIONS.special_achinery, _bottom-(height_special_achinery+301), _bottom-300);
  				changeBg(scrolled_top, 'orange-gr', _top+950, _bottom+30, '#B37F52');

  				/* Motor transport */
  				_top = _bottom - 1000;
  				_bottom += height_motor_transport;
  				if(scrolled_top >= _top && scrolled_top <= _bottom){
  					motor_transport.css('background-position','50% '+(-(scrolled_top-_top)*0.2)+'px')
  				}
  				activationMenu(scrolled_top,OPTIONS.motor_transport, _bottom-(height_motor_transport+301), _bottom-300);
  				changeBg(scrolled_top, 'gray-gr', _top+1030, _bottom+100, '#5C5C5C');

  				/* Equement */
  				_top = _bottom - 1000;

  				_bottom += height_equipment;
  				if(scrolled_top >= _top && scrolled_top <= _bottom){
  					equipment.css('background-position','50% '+(-(scrolled_top-_top)*0.2)+'px')
  				}
  				activationMenu(scrolled_top,OPTIONS.equipment, _bottom-(height_equipment+301), _bottom-300);
  				changeBg(scrolled_top, 'black-gr', _top+1100, _bottom+30, '#343434');

  				/* Request */
  				_top = _bottom - 900;
  				_bottom += height_request;
  				if(scrolled_top >= _top && scrolled_top <= _bottom){
  					request.css('background-position','50% '+(-(scrolled_top-_top)*0.2)+'px')
  				}
  				activationMenu(scrolled_top,OPTIONS.request, _bottom-(height_request+301), _bottom);
  				changeBg(scrolled_top, 'brown-2-gr', _top+1030, _bottom+30, '#523B3B');
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

  			function changeBg(scrolled_top, new_bg, start, end, color){
  				if(scrolled_top >= start && scrolled_top < end){
  					if(external_selector.data('value_bg') != new_bg){
  						external_selector.data('value_bg', new_bg);
  						external_selector.css('background-image','url("img/containers/'+new_bg+'.png")');

              colorPhone = color;
              switchPhone.find('.selected').css('background', color);
  					}
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








