@extends('layout.user.nav')
@section('content')
<section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('images/manggo.jpg');">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-center">
            <div class="col-md-9 ftco-animate pb-5 text-center">
                <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Beranda <i class="fa fa-chevron-right"></i></a></span> <span>Persebaran Komoditas <i class="fa fa-chevron-right"></i></span></p>
                <h1 class="mb-0 bread">Persebaran Komoditas</h1>
            </div>
        </div>
    </div>
</section>


<section class="ftco-section">
    <div class="container">

        <body>
            <div class="row mb-4">
                <div class="col-md-4">
                    <input type="text" id="searchDesa" class="form-control mb-2" placeholder="Cari Komoditas...">
                    <select id="filterDesa" class="form-control">
                        <option value="all">Semua Komoditas</option>
                        <option value="Desa1">Cabe Merah</option>
                        <option value="Desa2">Cabe Hijau</option>
                        <option value="Desa3">Kentang</option>
                        <!-- <option value="Desa4">Desa Pagaran</option>
                        <option value="Desa5">Desa Pahae Jae</option>
                        <option value="Desa6">Desa Pahae Julu</option>
                        <option value="Desa7">Desa Pangaribuan</option>
                        <option value="Desa8">Desa Parmonangan</option>
                        <option value="Desa9">Desa Purba Tua</option>
                        <option value="Desa10">Desa Siatas Barita</option>
                        <option value="Desa11">Desa Siborong Borong</option>
                        <option value="Desa12">Desa Simangumban</option>
                        <option value="Desa13">Desa Sipahutar</option>
                        <option value="Desa14">Desa Sipoholon</option>
                        <option value="Desa15">Desa Tarutung</option> -->
                    </select>
                </div>
            </div>

            <div class="row" id="komoditasContainer">
                <div class="col-md-4 ftco-animate" data-desa="Desa1">
                    <div class="project-wrap">
                        <a href="#" class="img" style="background-image: url(images/cabemerah.jpg);">

                        </a>
                        <div class="text p-4">
                            <h3><a href="#">Cabai Merah</a></h3>
                            <p class="location"><span class="fa fa-map-marker"></span> Indonesia</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate" data-desa="Desa2">
                    <div class="project-wrap">
                        <a href="#" class="img" style="background-image: url(images/cabehijau.jpg);">

                        </a>
                        <div class="text p-4">
                            <h3><a href="#">Cabai Hijau</a></h3>
                            <p class="location"><span class="fa fa-map-marker"></span> Indonesia</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate" data-desa="Desa3">
                    <div class="project-wrap">
                        <a href="#" class="img" style="background-image: url(images/kentang.jpg);">

                        </a>
                        <div class="text p-4">
                            <h3><a href="#">Kentang</a></h3>
                            <p class="location"><span class="fa fa-map-marker"></span> Indonesia</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate" >
                    <div class="project-wrap">
                        <a href="#" class="img" style="background-image: url(images/tomat.jpg);">

                        </a>
                        <div class="text p-4">
                            <h3><a href="#">Tomat</a></h3>
                            <p class="location"><span class="fa fa-map-marker"></span> Indonesia</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate">
                    <div class="project-wrap">
                        <a href="#" class="img" style="background-image: url(images/wortel.jpg);">

                        </a>
                        <div class="text p-4">
                            <h3><a href="#">Wortel</a></h3>
                            <p class="location"><span class="fa fa-map-marker"></span> Indonesia</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate">
                    <div class="project-wrap">
                        <a href="#" class="img" style="background-image: url(images/bawangmerah.jpg);">

                        </a>
                        <div class="text p-4">
                            <h3><a href="#">Bawang Merah</a></h3>
                            <p class="location"><span class="fa fa-map-marker"></span> Indonesia</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate" >
                    <div class="project-wrap">
                        <a href="#" class="img" style="background-image: url(images/bawangputih.jpg);">

                        </a>
                        <div class="text p-4">
                            <h3><a href="#">Bawang Putih</a></h3>
                            <p class="location"><span class="fa fa-map-marker"></span> Indonesia</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate">
                    <div class="project-wrap">
                        <a href="#" class="img" style="background-image: url(images/andaliman.jpg);">

                        </a>
                        <div class="text p-4">
                            <h3><a href="#">Andaliman</a></h3>
                            <p class="location"><span class="fa fa-map-marker"></span> Indonesia</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 ftco-animate" >
                    <div class="project-wrap">
                        <a href="#" class="img" style="background-image: url(images/bawangbombay.jpg);">

                        </a>
                        <div class="text p-4">
                            <h3><a href="#">Bawang Bombay</a></h3>
                            <p class="location"><span class="fa fa-map-marker"></span> Indonesia</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col text-center">
                    <div class="block-27">
                        <ul>
                            <li><a href="#">&lt;</a></li>
                            <li class="active"><span>1</span></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&gt;</a></li>
                        </ul>
                    </div>
</section>

<script>
    document.getElementById('searchDesa').addEventListener('input', function() {
        let filter = this.value.toLowerCase();
        let dropdown = document.getElementById('filterDesa');
        let options = dropdown.getElementsByTagName('option');

        for (let i = 0; i < options.length; i++) {
            let text = options[i].textContent.toLowerCase();
            if (text.includes(filter) || options[i].value === "all") {
                options[i].style.display = "block";
            } else {
                options[i].style.display = "none";
            }
        }
    });

    document.getElementById('filterDesa').addEventListener('change', function() {
        let selectedDesa = this.value;
        let items = document.querySelectorAll('#komoditasContainer .col-md-4');

        items.forEach(item => {
            if (selectedDesa === "all" || item.getAttribute('data-desa') === selectedDesa) {
                item.style.display = "block";
            } else {
                item.style.display = "none";
            }
        });
    });
</script>

@endsection