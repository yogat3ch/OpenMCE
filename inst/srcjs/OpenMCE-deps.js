Shiny.addCustomMessageHandler("HTMLText", function (data) {
  eval(data.jscode);
});
Shiny.addCustomMessageHandler("UpdateOpenMCE", function (data) {
  tinyMCE.get(data.id).setContent(data.content);
  $("#" + data.id).trigger("change");
});
Shiny.addCustomMessageHandler('PlaceholderText', function (data) {
  tinyMCE.get(data.id).getBody().setAttribute('data-mce-placeholder', data.html);
})