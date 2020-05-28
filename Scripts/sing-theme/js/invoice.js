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

    $('[href="../App_Themes/Estandar/Estandar.min.css"').remove();
    $('[href="../App_Themes/Estandar/Estandar.css"').remove();
});