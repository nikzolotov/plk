$(function(){
	run_tabs('#tabs', '.b-tabs-compact a', '.js-tab', 'region-1');
	run_tabs('#tabs_docs', '.b-tabs-docs a', '.js-category', 'category-1');
	run_tabs('#tabs_news', '.b-tabs-compact a', '.js-news', 'year-2011');
	

	function run_tabs(name_tabs, links, tab_selector, _hash){
		$(name_tabs).tabs({
			linkSelector: links,
			tabSelector: tab_selector,
			onSwitchTab: function(){
				$.history.load( $(this).attr('href').substr(5) );
			}
		});
		$.history.init(function(hash){
			if( hash == '' ){
				hash = _hash;
			}
			hash = hash.replace('tab-', '');
			$(name_tabs+' a[href=#tab-' + hash + ']').trigger('clickOnly');
		});
	}
    $('.b-moving-car').movingCar();
    $('#external_content .b-main-navigation').parallaxScroll();
    $('#external_content .b-main-navigation, .b-navigation-deployed').smoothScrolling();
});












(function( $ ){
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
             link_about_company: '.item-about .link',
             link_special_achinery: '.item-special-technics .link',
             link_transpor: '.item-motor-vehicles .link',
             link_equipment: '.item-equipment .link',
             link_request: '.item-request .link',
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
				link_about_company = $(OPTIONS.link_about_company, container),
				link_special_achinery = $(OPTIONS.link_special_achinery, container),
				link_transpor = $(OPTIONS.link_transpor, container),
				link_equipment = $(OPTIONS.link_equipment, container),
				link_request = $(OPTIONS.link_request, container),
				all_links = $(OPTIONS.all_links, container);

				link_about_company.data('selected',false);
				link_special_achinery.data('selected',false);
				link_transpor.data('selected',false);
				link_equipment.data('selected',false);
				link_request.data('selected',false);

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


				if(scrolled_top >= 0 && scrolled_top <= 1200){
					$('#main_section').css('background-position','50% '+(-scrolled_top*0.2)+'px')
				}
				if(scrolled_top >= 200 && scrolled_top <= 2622){
					$('#about').css('background-position','50% '+(-(scrolled_top-200)*0.2)+'px')
				}
				activationMenu(scrolled_top,link_about_company, 900, 2450);

				if(scrolled_top >= 1600 && scrolled_top <= 4390){
					$('#special-technics').css('background-position','50% '+(-(scrolled_top-1600)*0.2)+'px')
				}
				activationMenu(scrolled_top,link_special_achinery, 2451, 4099);

				if(scrolled_top >= 3300 && scrolled_top <= 6062){
					$('#motor-vehicles').css('background-position','50% '+(-(scrolled_top-3300)*0.2)+'px')
				}
				activationMenu(scrolled_top,link_transpor, 4100, 5650);

				if(scrolled_top >= 5300 && scrolled_top <= 7786){
					$('#equipment').css('background-position','50% '+(-(scrolled_top-5300)*0.2)+'px')
				}
				activationMenu(scrolled_top,link_equipment, 5651, 7450);

				if(scrolled_top >= 6900 && scrolled_top <= 9003){
					$('#request').css('background-position','50% '+(-(scrolled_top-6900)*0.2)+'px')
				}
				activationMenu(scrolled_top,link_request, 7451, 8903);
			}

			function activationMenu(scrolled_top,link,start,end){
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
             all_links: '.link'
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
				    if($.browser.safari || $.browser.webkit) $('body').animate( { scrollTop: destination }, 1100 );
				    else $('html').animate( { scrollTop: destination }, 1100 );

				    event.preventDefault();
			    });
			}
	
        });
     };

})( jQuery );








