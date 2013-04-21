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
    var myMapTver = new ymaps.Map("map_tver", {
        center: [56.845871, 35.895134],
        zoom: 14,
        type: "yandex#map"
    });

    myPlacemarkTver = new ymaps.Placemark([56.843871, 35.895134], {
        iconContent: '<b class="b-icon b-icon-map"><b></b></b>',
        balloonContentHeader: '<h3 class="b-map-title">Первая Лизинговая Компания</h3>',
        balloonContentBody: '<p class="b-map-content">Россия, Тверь, 170100 <br>улица Володарского, дом 34 (здание ОАО «Тверьуниверсалбанк», 3 этаж).</p>'
    }, {
        preset: 'twirl#blueStretchyIcon'
    });

    myMapTver.geoObjects
        .add(myPlacemarkTver);
    myMapTver.controls.add('smallZoomControl', {left: 10, top: 10});

    var myMapMoscow = new ymaps.Map("map_moscow", {
        center: [55.755773, 37.617761],
        zoom: 14,
        type: "yandex#map"
    });

    myPlacemarkMoscow = new ymaps.Placemark([55.755773, 37.617761], {
        iconContent: '<b class="b-icon b-icon-map"><b></b></b>',
        balloonContentHeader: '<h3 class="b-map-title">Первая Лизинговая Компания</h3>',
        balloonContentBody: '<p class="b-map-content">Россия, Москва, 170100 <br>улица Володарского, дом 34 (здание ОАО «Тверьуниверсалбанк», 3 этаж).</p>'
    }, {
        preset: 'twirl#blueStretchyIcon'
    });

    myMapMoscow.geoObjects
        .add(myPlacemarkMoscow);
    myMapMoscow.controls.add('smallZoomControl', {left: 10, top: 10});
}
