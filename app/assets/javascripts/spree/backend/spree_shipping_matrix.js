$(document).on('click', '.js-remove-row', function () {
  var $removeLink = $(this);
  var $row = $removeLink.closest('.row');
  var destroyName = $removeLink.data('row-object-name') + '[_destroy]';
  $row.replaceWith(
    '<input type="hidden" name="' + destroyName + '" value="1" />');
  return false;
});

$(document).on('click', '.js-duplicate-last-row', function () {
  var $duplicateLink = $(this);
  var $row = $duplicateLink.prev();
  var reRowId = /\[([0-9]+)\]/;
  var rowId = parseInt(reRowId.exec($row.find('[name]:first').attr('name'))[1], 10);
  var newRowId = rowId + 1;
  var $duplicateRow = $row.clone();

  $duplicateRow.find('[for]').each(function () {
    var labelFor = $(this).attr('for');
    $(this).attr('for', labelFor.replace('_' + rowId + '_', '_' + newRowId + '_'));
  });

  $duplicateRow.find('[name]').each(function () {
    var name = $(this).attr('name');
    var id = $(this).attr('id');
    $(this).attr('id', id.replace('_' + rowId + '_', '_' + newRowId + '_'));
    $(this).attr('name', name.replace(reRowId, '[' + newRowId + ']'));
  });

  $duplicateRow.find('.select2-container').remove();

  $duplicateLink.before($duplicateRow);

  $('select.select2').select2({
    allowClear: true,
    dropdownAutoWidth: true
  });

  return false;
});
