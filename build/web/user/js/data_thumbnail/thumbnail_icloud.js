/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/*Thambnail View*/
var thumbnails = $('<ul></ul>').attr('id', 'theThumbnails').insertAfter('#dataTable').hide();
$('#dataTable tbody #dataFolder').each(function () {
    var cells = $(this).find('td');
    var fpath = $(cells[1]).find('a').attr('href');
    var thumbnail = $('<a></a>').addClass('thumbnail_data btn btn-app').attr('href', fpath);
    //$('<button type="button" class=" btn btn-default btn-data"><i class="fa fa-angle-down"></i></button>').appendTo(thumbnail);
    $('<span class="badge bg-green"></span>').text($(cells[2]).text()).appendTo(thumbnail);
    $('<i class="fa fa-folder thumbnail_big custom_color_folder"></i>').text($(cells[0]).text()).appendTo(thumbnail);
    $('<h5 class="thumbnail_h5"></h5>').text($(cells[1]).find('a').text()).appendTo(thumbnail);
    $('<p class="thumbnail_p"></p>').text($(cells[1]).find('small').text().slice(9, 30)).appendTo(thumbnail);
    thumbnail.appendTo(thumbnails);
});

var thumbnails_file = $('<ul class="theThumbnail_file"></ul>').attr('id', 'theThumbnails_file').insertAfter('#theThumbnails').hide();
$('#dataTable tbody #dataFile').each(function () {
    var cells = $(this).find('td');
    var thumbnail = $('<a href="#"></a>').addClass('thumbnail_data');
    var classname = $(cells[0]).find('i').attr('class');
    $('<i></i>').text($(cells[0]).text()).appendTo(thumbnail).addClass(classname + ' thumbnail_big');
    $('<h5 class="thumbnail_h5"></h5>').text($(cells[1]).find('a').text().slice(0, 10)).append('...').appendTo(thumbnail);
    $('<p class="thumbnail_p"></p>').text($(cells[1]).find('small').text().slice(9, 30)).appendTo(thumbnail);
    thumbnail.appendTo(thumbnails_file);
});

function changeView() {
    $('#dataTable').hide();
    $('#theThumbnails').show();
    $('#theThumbnails_file').show();
}
function changeViewList() {
    $('#dataTable').show();
    $('#theThumbnails').hide();
    $('#theThumbnails_file').hide();
}

//            $('#changeview').live('click', function () {
//                
//            });

/*Sort on Type*/
function loadData(ftype) {
    $('#dataTable tbody #dataFolder').each(function () {
    $(this).hide();
    });
if(ftype == 1){
//    $('#theThumbnails').hide();
//        $('#theThumbnails_file a').each(function(){
//             var cells = $(this).find('i').attr('class').split(' ');
//             if (cells[1] == 'fa-file-pdf-o' || cells[1] == 'fa-file-word-o' || cells[1] == 'fa-file-powerpoint-o' ) {        
//                $(this).show();
//            }else{
//                $(this).hide();
//            }
//        });
          $('#dataTable tbody #dataFile').each(function () {
            var cells = $(this).find('td');
            //var filename = ;
            var outp = reverse($(cells[1]).find('a').text()).split('.');     
            $('#dataFolder').hide();
            if (reverse(outp[0]) == 'pdf' || reverse(outp[0]) == 'docx' || reverse(outp[0]) == 'doc') {
                $(this).show();
            }else{
                $(this).hide();
            }
        });
}
if(ftype == 2){
     $('#dataFolder').hide();
          $('#dataTable tbody #dataFile').each(function () {
            var cells = $(this).find('td');
            //var filename = ;
            var outp = reverse($(cells[1]).find('a').text()).split('.');     
            $('#dataFolder').hide();
            if (reverse(outp[0]) == 'rar' || reverse(outp[0]) == 'zip' || reverse(outp[0]) == '7zip'|| reverse(outp[0]) == 'tar') {
                $(this).show();
            }else{
                $(this).hide();
            }
        });
}
if(ftype == 3){
//     $('#theThumbnails').hide();
//        $('#theThumbnails_file a').each(function(){
//             var cells = $(this).find('i').attr('class').split(' ');
//             if (cells[1] == 'fa-image') {        
//                $(this).show();
//            }else{
//                $(this).hide();
//            }
//        });
     $('#dataFolder').hide();
          $('#dataTable tbody #dataFile').each(function () {
            var cells = $(this).find('td');
            //var filename = ;
            var outp = reverse($(cells[1]).find('a').text()).split('.');     
            $('#dataFolder').hide();
            if (reverse(outp[0]) == 'jpg' || reverse(outp[0]) == 'png' || reverse(outp[0]) == 'gif') {
                $(this).show();
            }else{
                $(this).hide();
            }
        });
}

    if (ftype == 5) {
//        $('#theThumbnails').hide();
//        $('#theThumbnails_file a').each(function(){
//             var cells = $(this).find('i').attr('class').split(' ');
//             if (cells[1] == 'fa-music') {        
//                $(this).show();
//            }else{
//                $(this).hide();
//            }
//        });
        $('#dataTable tbody #dataFile').each(function () {
            var cells = $(this).find('td');
            var filename = $(cells[1]).find('a').text();
            var outp = reverse(filename).split('.');
            $('#dataFolder').hide();
            if (reverse(outp[0]) == 'mp3' || reverse(outp[0]) == 'm4a' || reverse(outp[0]) == 'mid' || reverse(outp[0]) == 'aac' || reverse(outp[0]) == 'wav') {
                $(this).show();
            }else{
                $(this).hide();
            }
        });
    }
    if(ftype == 4){
     $('#dataFolder').hide();
          $('#dataTable tbody #dataFile').each(function () {
            var cells = $(this).find('td');
            //var filename = ;
            var outp = reverse($(cells[1]).find('a').text()).split('.');     
            $('#dataFolder').hide();
            if (reverse(outp[0]) == 'mp4' || reverse(outp[0]) == 'flv' || reverse(outp[0]) == '3gp'|| reverse(outp[0]) == 'mov' || reverse(outp[0]) == 'mpeg' || reverse(outp[0]) == 'xvid' || reverse(outp[0]) == 'avi') {
                $(this).show();
            }else{
                $(this).hide();
            }
        });
}
}
function reverse(s) {
    var o = [];
    for (var i = 0, len = s.length; i <= len; i++)
        o.push(s.charAt(len - i));
    return o.join('');
}