$(".cm_notifier").live('click', function () {
  $("#copy_machine_traces").slideToggle('slow');
});

$(".cm_close_button").live('click', function () {
  $(this).parent().remove();
  $("#copy_machine_traces").remove();
});
