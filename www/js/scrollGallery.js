(function($){
	$.fn.scrollGallery = function( userOptions ){
		var OPTIONS = {
			slidesContainer: '.slides',
			slideSelector: '.slide',
			navigation: '.navigation',
			hiddenContent: '.title, .desc',
			linkSelector: '.link',
			linkSelected: 'selected',
			firstItemHtml: '<div class="item"><a href="?" class="link"><span class="text">',
			endItemHtml: '</span></a></div>',
			titleItems: '.title',
			minSlidesWidth: 1070,
			animationTime: 200,
			animationHiddenContent: 200,
			scrollChangeSlides: 100,
			existenceNavigation: false
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
				galleryTop = Math.ceil(container.offset().top) - 150,
				currentPage = 0,
				prevSlide = 0,
				slideWidth = 0,
				maxFixed = (slidesCount * OPTIONS.scrollChangeSlides) - OPTIONS.scrollChangeSlides -1;


			if(!OPTIONS.existenceNavigation && slidesCount > 1){
				var linkNavigation;

				prepareNavigation();
			}

			installSizeSlides();
			$(window).resize(function(){
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
					title = '';
				
				for( var i = 0; i < slidesCount; i++ ){
					title = slides.eq(i).find(OPTIONS.titleItems).text();
					itemHtml += OPTIONS.firstItemHtml+title+OPTIONS.endItemHtml;
				}
				navigation.html(itemHtml);

				linkNavigation = $(OPTIONS.linkSelector, navigation);

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
			}

			function fixedGallery(){
				scrollTop = $(window).scrollTop();

				if(scrollTop >= galleryTop){
					valuePadding = scrollTop-galleryTop;
					if(valuePadding < maxFixed){
						container.css('padding-top',scrollTop-galleryTop);
						changeSlide(scrollTop-galleryTop);
					}
					else {
						container.css('padding-top', maxFixed);
						prevSlide = currentPage;
						currentPage = slidesCount - 1;
						switchSlide();
					}
					
				}
				else {
					container.css('padding-top',0);
					prevSlide = currentPage;
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

						prevSlide = currentPage;
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
					prevSlide = currentPage;
					currentPage = numberSlide;
					switchSlide(positionScroll);
				}
			}

			function switchSlide(positionScroll){
				valueMargin = parseInt(slidesContainer.css('margin-right')),
				oldMargin = prevSlide * slideWidth * -1,
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














