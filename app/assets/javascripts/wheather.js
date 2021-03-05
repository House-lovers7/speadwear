
$(function() {
    var API_KEY = '77c8893b98e40f9d39eb2365cf3bf351'
    var city =    'Tokyo';
    //  var url =     'https://api.openweathermap.org/data/2.5/weather?q=Tokyo&units=metric&lang=ja&appid=77c8893b98e40f9d39eb2365cf3bf351';
  
    var url =     'https://api.openweathermap.org/data/2.5/onecall?lat=35.68&lon=139.77&exclude=minutely,hourly,alerts&units=metric&lang=ja&appid=77c8893b98e40f9d39eb2365cf3bf351';
  
  
    $.ajax({
      url: url,
      dataType: "json",
      type: 'GET',
      })
    .done(function(data) {
      console.log(data);
      console.log(data.daily[0].weather[0].icon);
      var insertHTML = "";
  
      // 今日の天気
      var cityName = '<p>'+  "東京の天気" + '</p>';
       $('#city-name').html(cityName);
      var weather0 = '<p>' + data.daily[0].weather[0].description +'</p>';
       $('#weather0').html(weather0);
       var temp0 = '<p>' + data.daily[0].temp.day + "℃" + '</p>';
       $('#temp0').html(temp0);
       var icon0 = '<img src="http://openweathermap.org/img/wn/'+ data.daily[0].weather[0].icon + '.png">';
       $('#icon0').html(icon0);
       // 明日の天気
      var weather1 = '<p>' + data.daily[1].weather[0].description +'</p>';
       $('#weather1').html(weather1);
       var temp1 = '<p>' + data.daily[1].temp.day + "℃" + '</p>';
       $('#temp1').html(temp1);
       var icon1 = '<img src="http://openweathermap.org/img/wn/'+ data.daily[1].weather[0].icon + '.png">';
       $('#icon1').html(icon1);
  　　　// 明後日の天気
      var weather2 = '<p>' + data.daily[2].weather[0].description +'</p>';
       $('#weather2').html(weather2);
       var temp2 = '<p>' +  data.daily[2].temp.day + "℃" + '</p>';
       $('#temp2').html(temp2);
       var icon2 = '<img src="http://openweathermap.org/img/wn/'+ data.daily[2].weather[0].icon + '.png">';
       $('#icon2').html(icon2);
        // ３日後の天気
       var cityName = '<p>'+  "東京の天気" + '</p>';
       $('#city-name').html(cityName);
      var weather3 = '<p>' + data.daily[3].weather[0].description +'</p>';
       $('#weather3').html(weather0);
       var temp3 = '<p>' + data.daily[3].temp.day + "℃" + '</p>';
       $('#temp3').html(temp3);
       var icon3 = '<img src="http://openweathermap.org/img/wn/'+ data.daily[3].weather[0].icon + '.png">';
       $('#icon3').html(icon3);
  
    })
  
  
    // 下記を書き込むとErrorがでる
    // .done(function(data) {
    //   var insertHTML = "";
    //   var cityName = '<h2>' + data.name + '</h2>';
    //   $('#city-name').html(cityName);
    //   for (var i = 0; i <= 8; i = i + 2) {
    //     insertHTML += buildHTML(data, i);
    //   }
    //   $('#weather').html(insertHTML);
    // })
  
  // data.list[0].whether.id
  
  // list.weather.id
  
  
    .fail(function(data) {
      console.log("失敗しました");
    });
  });
  
  function buildHTML(data, i) {
    var Week = new Array("（日）","（月）","（火）","（水）","（木）","（金）","（土）");
     var date = new Date (data.list[i].dt_txt);
     date.setHours(date.getHours() + 9);
     var month = date.getMonth()+1;
     var day = month + "月" + date.getDate() + "日" + Week[date.getDay()] + date.getHours() + "：00";
     var icon = data.list[i].weather[0].icon;
    console.log(data);
    var html =
    '<div class="weather-report">' +
    '<img src="http://openweathermap.org/img/w/' + icon + '.png">' +
      '<div class="weather-date">' + day + '</div>' +
      '<div class="weather-main">'+ data.list[i].weather[0].main + '</div>' +
      '<div class="weather-temp">' + Math.round(data.list[i].main.temp) + '℃</div>' +
    '</div>';
    return html
  }
  