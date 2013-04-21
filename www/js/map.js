ymaps.ready(init);

function init () {
    var identification_map = true;
    param();
    
    $(".b-switch-phone .link").click(function (event, ui){
        if(!$(this).hasClass('selected')){
            if(identification_map) param();
            identification_map = false;
        }
    });
}

function param(){
    var myPlacemarkTver = new ymaps.Placemark([56.85646115670938, 35.91733099892737], {
        iconContent: '<b class="b-icon b-icon-map"><b></b></b>',
        balloonContentHeader: '<h3 class="b-map-title">Первая Лизинговая Компания</h3>',
        balloonContentBody: '<p class="b-map-content">Россия, Тверь, 170100 <br>улица Володарского, дом 34 (здание ОАО «Тверьуниверсалбанк», 3 этаж).</p>'
    }, {
        preset: 'twirl#blueStretchyIcon'
    });
    
    var myMapTver = new ymaps.Map("map_tver", {
        center: myPlacemarkTver.geometry.getCoordinates(),
        zoom: 15,
        type: "yandex#map"
    });


    myMapTver.geoObjects
        .add(myPlacemarkTver);
    myMapTver.controls.add('smallZoomControl', {left: 10, top: 10});

    var myPlacemarkMoscow = new ymaps.Placemark([55.788390105635685, 37.508867997676155], {
        iconContent: '<b class="b-icon b-icon-map"><b></b></b>',
        balloonContentHeader: '<h3 class="b-map-title">Первая Лизинговая Компания</h3>',
        balloonContentBody: '<p class="b-map-content">Россия, Москва, 170100 <br>улица Володарского, дом 34 (здание ОАО «Тверьуниверсалбанк», 3 этаж).</p>'
    }, {
        preset: 'twirl#blueStretchyIcon'
    });
	
    var myMapMoscow = new ymaps.Map("map_moscow", {
        center: myPlacemarkMoscow.geometry.getCoordinates(),
        zoom: 15,
        type: "yandex#map"
    });

    myMapMoscow.geoObjects
        .add(myPlacemarkMoscow);
    myMapMoscow.controls.add('smallZoomControl', {left: 10, top: 10});
}
