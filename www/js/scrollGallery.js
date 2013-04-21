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
				paddingTopGallery = 0,
				currentPage = 0,
				slideWidth = 0;

			if(!OPTIONS.existenceNavigation && slidesCount > 1){
				var linkNavigation;
				prepareNavigation();
			}

			installSizeSlides();
			$(window).resize(function(){
				installSizeSlides();
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
					}
					switchSlide();
					event.preventDefault();
				});
			}


			function switchSlide(){
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















