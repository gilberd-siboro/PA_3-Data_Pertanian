<!DOCTYPE html>
<html lang="en">

<head>
    <title>Agromob - Dinas Pertanian</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Arizonia&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/glightbox/dist/css/glightbox.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="css/animate.css">

    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">

    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">


    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
        <div class="container">
            <a class="navbar-brand" href="/">Agromob<span>Dinas Pertanian</span></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="oi oi-menu"></span> Menu
            </button>

            <div class="collapse navbar-collapse" id="ftco-nav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item {{ \Request::is('/') ? 'active' : '' }}">
                        <a href="/" class="nav-link">Beranda</a>
                    </li>
                    <li class="nav-item {{ \Request::is('tentang') ? 'active' : '' }}">
                        <a href="/tentang" class="nav-link">Tentang</a>
                    </li>

                    <!-- Dropdown item -->
                    <li class="nav-item dropdown {{ \Request::is('komoditas-kecamatan') || \Request::is('persebaran-komoditas') ? 'active' : '' }}">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Data Pertanian
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item {{ \Request::is('komoditas-kecamatan') ? 'active' : '' }}" href="/komoditas-kecamatan">Komoditas Kecamatan</a>
                            <a class="dropdown-item {{ \Request::is('persebaran-komoditas') ? 'active' : '' }}" href="/persebaran-komoditas">Persebaran Komoditas</a>
                            <a class="dropdown-item {{ \Request::is('harga-komoditas') ? 'active' : '' }}" href="/harga-komoditas">Harga Komoditas</a>
                            <a class="dropdown-item {{ \Request::is('tren-harga') ? 'active' : '' }}" href="/tren-harga">Tren Harga</a>
                        </div>
                    </li>
                </ul>
            </div>

        </div>
    </nav>
    <!-- END nav -->
    @yield('content')

    <footer class="ftco-footer bg-bottom ftco-no-pt" style="background-image: url(images/bg.jpg);">
        <div class="container">
            <div class="row mb-5">
                <!-- <div class="col-md pt-5">
                    <div class="ftco-footer-widget pt-md-5 mb-4">
                        <h2 class="ftco-heading-2">About</h2>
                        <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                        <ul class="ftco-footer-social list-unstyled float-md-left float-lft">
                            <li class="ftco-animate"><a href="#"><span class="fa fa-twitter"></span></a></li>
                            <li class="ftco-animate"><a href="#"><span class="fa fa-facebook"></span></a></li>
                            <li class="ftco-animate"><a href="#"><span class="fa fa-instagram"></span></a></li>
                        </ul>
                    </div>
                </div> -->
                <div class="col-md pt-5 border-left">
                    <div class="ftco-footer-widget pt-md-5 mb-4 ml-md-5">
                        <h2 class="ftco-heading-2">Informasi</h2>
                        <ul class="list-unstyled">
                            <li><a href="#" class="py-2 d-block">Beranda</a></li>
                            <li><a href="#" class="py-2 d-block">Tentang</a></li>
                            <li><a href="#" class="py-2 d-block">Komoditas Kecamatan</a></li>
                            <li><a href="#" class="py-2 d-block">Persebaran Komoditas</a></li>
                            <li><a href="#" class="py-2 d-block">Harga Komoditas</a></li>
                            <li><a href="#" class="py-2 d-block">Tren Harga Komoditas</a></li>
                            <li><a href="#" class="py-2 d-block">Berita</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md pt-5 border-left">
                    <div class="ftco-footer-widget pt-md-5 mb-4">
                        <h2 class="ftco-heading-2">Hubungi Kami</h2>
                        <div class="block-23 mb-3">
                            <ul>
                                <li><span class="icon fa fa-map-marker"></span><span class="text">Dinas Pertanian Kabupaten Tapanuli Utara
                                        Jl. SM. Simanjuntak No. 1 Tarutung
                                        Tapanuli Utara, Sumatera Utara
                                        Kode Pos 22411</span></li>
                                <li><a href="#"><span class="icon fa fa-phone"></span><span class="text">
                                            081263764112</span></a></li>
                                <li><a href="#"><span class="icon fa fa-paper-plane"></span><span class="text">dinaspertaniantaput@gmail.com</span></a></li>
                            </ul>

                        </div>
                        <ul class="ftco-footer-social list-unstyled float-md-left float-lft">
                            <li class="ftco-animate"><a href="https://www.youtube.com/channel/UCPjDJcWjzuoS8RfYuqb9C8w"><span class="fa fa-youtube"></span></a></li>
                            <li class="ftco-animate"><a href="https://web.facebook.com/dinaspertanian.tapanuliutara"><span class="fa fa-facebook"></span></a></li>
                            <li class="ftco-animate"><a href="https://www.instagram.com/dinaspertaniantaput/"><span class="fa fa-instagram"></span></a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md pt-5 border-left">
                    <div class="ftco-footer-widget pt-md-5 mb-4">
                        <h2 class="ftco-heading-2">Dinas Pertanian Tapanuli Utara</h2>

                    </div>
                </div>
            </div>
        </div>
    </footer>



    <!-- loader -->
    <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px">
            <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" />
            <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" />
        </svg></div>


    <script src="js/jquery.min.js"></script>
    <script src="js/jquery-migrate-3.0.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/jquery.stellar.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/jquery.animateNumber.min.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script src="js/scrollax.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
    <script src="js/google-map.js"></script>
    <script src="js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/glightbox/dist/js/glightbox.min.js"></script>

</body>

</html>