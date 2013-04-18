ymaps.ready(function(){ 
    var myMap = new ymaps.Map("YMapsID", {
        center: [56.845871, 35.895134],
        zoom: 14,
        type: "yandex#map"
    });

    myPlacemark = new ymaps.Placemark([56.843871, 35.895134], {
        iconContent: '<b class="b-icon b-icon-map"><b></b></b>',
        balloonContentHeader: '<h3 class="b-map-title">Первая Лизинговая Компания</h3>',
        balloonContentBody: '<p class="b-map-content">Россия, Тверь, 170100 <br>улица Володарского, дом 34 (здание ОАО «Тверьуниверсалбанк», 3 этаж).</p>'
    }, {
        preset: 'twirl#blueStretchyIcon'
    });

    myMap.geoObjects
        .add(myPlacemark);
    myMap.controls.add('smallZoomControl', {left: 10, top: 10});
});