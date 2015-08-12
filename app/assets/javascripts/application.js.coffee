#= require jquery
#= require jquery_ujs
#= require dataTables/jquery.dataTables
#= require bootstrap-sprockets
#= require cocoon
#= require turbolinks
#= require_tree .
jQuery ->
   $('#table_id').DataTable({
    paging: true
    pageLength: 50
} );