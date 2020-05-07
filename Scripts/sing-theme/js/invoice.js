//$(function () {

//    function pageLoad() {
//        $('.print').click(function () {
//            window.print();
//        });
//    }

//    pageLoad();
//    SingApp.onPageLoad(pageLoad);

//});

$(document).ready(function () {
    $('.print').click(function (e) {
        e.preventDefault();
        window.print();
    });
    // Super Hacky way to prevent 'Estandar' style to load
    $('[href="../App_Themes/Estandar/Estandar.css"').remove();
});