$(function() {
  $("#js-suggest-registration-area").hide();
  $("#js-suggest-registration-indiv-area").hide();
})

$("#js-complete-recover-button").on('click', function(e) {
  $("#js-suggest-registration-area").show();
  $(this).prop("disabled", true);
  // ページトップまでスクロールしないようにする
  e.preventDefault();
});

$("#js-complete-indiv-button").on('click', function(e) {
  $("#js-suggest-registration-indiv-area").show();
  day_field = $("#indiv-day")
  // 分割メニュー（n日目）のnに一を足す
  if (parseInt($("#indiv-day").text()) < 3) {
    $("#indiv-day").text(`${parseInt($("#indiv-day").text()) + 1}`);
  }

  switch (parseInt($("#indiv-day").text())) {
    case 1:
      $("#indiv-item0").text("脚トレ1")
      $("#indiv-item1").text("脚トレ2")
      $("#indiv-item2").text("脚トレ3")
      $("#indiv-item3").text("脚トレ4")
      $("#indiv-item4").text("脚トレ5")
      break;
    case 2:
      $("#indiv-item0").text("肩トレ1")
      $("#indiv-item1").text("肩トレ2")
      $("#indiv-item2").text("肩トレ3")
      $("#indiv-item3").text("肩トレ4")
      $("#indiv-item4").text("肩トレ5")
      break;
    case 3:
      $("#indiv-item0").text("胸トレ1")
      $("#indiv-item1").text("胸トレ2")
      $("#indiv-item2").text("胸トレ3")
      $("#indiv-item3").text("胸トレ4")
      $("#indiv-item4").text("胸トレ5")
      break;
  }

  $(this).prop("disabled", true);
  // ページトップまでスクロールしないようにする
  e.preventDefault();
});