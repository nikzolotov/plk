(function($){
	$.fn.scrollGallery = function( userOptions ){
		var OPTIONS = {
			slidesContainer: '.slides',
			slideSelector: '.slide',
			navigation: '.navigation',
			hiddenContent: '.title, .desc',
			linkSelector: '.link',
			linkSelected: 'selected',
			titleItems: '.title',
			containerFixed: 'b-scroll-gallery-fixed',
			containerAbsolute: 'b-scroll-gallery-absolute',
			minSlidesWidth: 1000,
			animationTime: 200,
			animationHiddenContent: 200,
			scrollChangeSlides: 500,
			existenceNavigation: false,
			heightForParrallax: '#about'
		};

		return this.each(function(){
			if( userOptions ){
				$.extend( OPTIONS, userOptions );
			}
			
			var container = $(this),
				slidesContainer = $(OPTIONS.slidesContainer, container),
				slides = $(OPTIONS.slideSelector, container),
				navigation = $(OPTIONS.navigation, container),
				hiddenContent = $(OPTIONS.hiddenContent, container),
				slidesCount = slides.length,
				heightForParrallax = $(OPTIONS.heightForParrallax),
				galleryTop = Math.ceil(container.offset().top) - 144,
				paddingTopGallery = 0,
				currentPage = 0,
				slideWidth = 0,
				maxFixed = (slidesCount * OPTIONS.scrollChangeSlides) - OPTIONS.scrollChangeSlides/2 -1;

			if($.browser.opera || $.browser.firefox) galleryTop = Math.ceil(container.offset().top) - 72;

			
			installGallaryTop();
			if(!OPTIONS.existenceNavigation && slidesCount > 1){
				var linkNavigation;

				prepareNavigation();
			}

			
			installSizeSlides();
			$(window).resize(function(){
				fixedGallery();
				installSizeSlides();
			});

			fixedGallery();
			$(window).bind('scroll',function(event){
				fixedGallery();
			});

			manageLinks();
			assignEvents();

			

			function prepareNavigation(){			
				var itemHtml = '',
					title = '',
					nextClass = '';
				for( var i = 0; i < slidesCount; i++ ){
					title = slides.eq(i).find(OPTIONS.titleItems).text();
					if(slides.eq(i).hasClass('next-line')) nextClass = 'item-without-point'
					else nextClass = ''
					itemHtml += '<div class="item '+nextClass+'"><a href="?" class="link"><span class="text">'+title+'</span></a></div>';
				}
				navigation.html(itemHtml);

				linkNavigation = $(OPTIONS.linkSelector, navigation);
				
				heightForParrallax.height( heightForParrallax.height() + maxFixed + 143 );
			}

			function installGallaryTop(){

				var mistake = 0,
					containerHeight = 538,
					windowHeight = $(window).height();

				if(containerHeight < windowHeight) {
					fixed = (windowHeight-containerHeight)/2 - 72;
				}
				else {
					fixed = 0;
				}
				galleryTop -= fixed;
				paddingTopGallery = fixed;
				maxFixed += paddingTopGallery;

				
			}

			function installSizeSlides(){
				var windowWidth = $(window).width();
				if(windowWidth > OPTIONS.minSlidesWidth){
					slideWidth = windowWidth/2;
					slides.width(slideWidth);

				}
				else {
					slideWidth = OPTIONS.minSlidesWidth/2;
					slides.width(slideWidth);
				}
				newMargin = currentPage * slideWidth * -1;
				slidesContainer.css('margin-right', newMargin);

			}

			function fixedGallery(){
				scrollTop = $(window).scrollTop();
				if(scrollTop >= galleryTop){
					valuePadding = scrollTop-galleryTop;
					if(valuePadding < maxFixed){
						
						container.removeClass(OPTIONS.containerAbsolute).addClass(OPTIONS.containerFixed).css('padding-top',paddingTopGallery);
						changeSlide(scrollTop-galleryTop);
					}
					else {
						container.removeClass(OPTIONS.containerFixed).addClass(OPTIONS.containerAbsolute).css('padding-top',0);
						currentPage = slidesCount - 1;
						switchSlide();
					}
					
				}
				else {
					container.removeClass(OPTIONS.containerFixed).removeClass(OPTIONS.containerAbsolute).css('padding-top',0);
					currentPage = 0;
					switchSlide();
				}
			}

			function manageLinks(){
				if( slidesCount > 1 ){
					linkNavigation.removeClass(OPTIONS.linkSelected);
					linkNavigation.eq(currentPage).addClass(OPTIONS.linkSelected);
				}
				
				hiddenContent.hide();
				slides.eq(currentPage).find(OPTIONS.hiddenContent).show();
			}

			function assignEvents(){
				
				linkNavigation.click(function(event){
					var thisIndex = linkNavigation.index($(this));

					if( thisIndex != currentPage ){

						currentPage = thisIndex;

						newScroll = galleryTop + (OPTIONS.scrollChangeSlides * currentPage);
						if($.browser.safari || $.browser.webkit) $('body').animate( { scrollTop: newScroll }, 100 );
				    	else $('html').animate( { scrollTop: newScroll }, 100 );
					}
					event.preventDefault();
				});
			}

			function changeSlide(positionScroll){
				numberSlide = Math.floor(positionScroll/OPTIONS.scrollChangeSlides);
				if(numberSlide < slidesCount){
					currentPage = numberSlide;
					switchSlide(positionScroll);
				}
			}

			function switchSlide(positionScroll){
				valueMargin = parseInt(slidesContainer.css('margin-right')),
				newMargin = currentPage * slideWidth * -1;

				if(newMargin != valueMargin){
					slidesContainer.animate({
						marginRight: currentPage * slideWidth * -1
					},{
						duration: OPTIONS.animationTime,
						queue: false
					});
				}
				manageLinks();
				
			}

		});
	};
})( jQuery );















