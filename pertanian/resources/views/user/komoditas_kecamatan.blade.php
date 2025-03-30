@extends('layout.user.nav')
@section('content')


<section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('images/cornfield.jpg');">
  <div class="overlay"></div>
  <div class="container">
    <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-center">
      <div class="col-md-9 ftco-animate pb-5 text-center">
         <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Beranda <i class="fa fa-chevron-right"></i></a></span> <span>Komoditas Kecamatan<i class="fa fa-chevron-right"></i></span></p>
         <h1 class="mb-0 bread">Komoditas Kecamatan</h1>
     </div>
 </div>
</div>
</section>


<!-- <section class="ftco-section">
   <div class="container">
    <div class="row">
      <div class="col-md-4 ftco-animate">
          <div class="project-wrap" data-kecamatan="Kecamatan1">
              <a href="#" class="img" style="background-image: url(images/cabemerah.jpg);">
 
              </a>
              <div class="text p-4">
                  <h3><a href="#">Cabai Merah</a></h3>
                  <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
              </div>
          </div>
      </div>
   <div class="col-md-4 ftco-animate">
      <div class="project-wrap">
         <a href="#" class="img" style="background-image: url(images/cabehijau.jpg);">
            <span class="price">Rp.550/Kg</span>
        </a>
        <div class="text p-4">
            <h3><a href="#">Cabai Hijau</a></h3>
            <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
       </div>
   </div>
</div>
<div class="col-md-4 ftco-animate">
  <div class="project-wrap">
     <a href="#" class="img" style="background-image: url(images/kentang.jpg);">
        <span class="price">Rp.550/Kg</span>
    </a>
    <div class="text p-4">
        <h3><a href="#">Kentang</a></h3>
        <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
   </div>
</div>
</div>

<div class="col-md-4 ftco-animate">
  <div class="project-wrap">
     <a href="#" class="img" style="background-image: url(images/tomat.jpg);">
        <span class="price">Rp.550/Kg</span>
    </a>
    <div class="text p-4">
        <h3><a href="#">Tomat</a></h3>
        <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
   </div>
</div>
</div>
<div class="col-md-4 ftco-animate">
  <div class="project-wrap">
     <a href="#" class="img" style="background-image: url(images/wortel.jpg);">
        <span class="price">Rp.550/Kg</span>
    </a>
    <div class="text p-4">
        <h3><a href="#">Wortel</a></h3>
        <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
   </div>
</div>
</div>
<div class="col-md-4 ftco-animate">
  <div class="project-wrap">
     <a href="#" class="img" style="background-image: url(images/bawangmerah.jpg);">
        <span class="price">Rp.550/Kg</span>
    </a>
    <div class="text p-4">
        <h3><a href="#">Bawang Merah</a></h3>
        <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
   </div>
</div>
</div>
<div class="col-md-4 ftco-animate">
  <div class="project-wrap">
     <a href="#" class="img" style="background-image: url(images/bawangputih.jpg);">
        <span class="price">Rp.550/Kg</span>
    </a>
    <div class="text p-4">
        <h3><a href="#">Bawang Putih</a></h3>
        <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
   </div>
</div>
</div>
<div class="col-md-4 ftco-animate">
  <div class="project-wrap">
     <a href="#" class="img" style="background-image: url(images/andaliman.jpg);">
        <span class="price">Rp.550/Kg</span>
    </a>
    <div class="text p-4">
        <h3><a href="#">Andaliman</a></h3>
        <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
   </div>
</div>
</div>
<div class="col-md-4 ftco-animate">
  <div class="project-wrap">
     <a href="#" class="img" style="background-image: url(images/bawangbombay.jpg);">
        <span class="price">Rp.550/Kg</span>
    </a>
    <div class="text p-4">
        <h3><a href="#">Bawang Bombay</a></h3>
        <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
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
</div>
</div>
</div>
</section> -->

<section class="ftco-section">
  <div class="container">
   
   <!-- Dropdown Filter Kecamatan -->
   <div class="row mb-4">
     <div class="col-md-4">
       <select id="filterKecamatan" class="form-control">
         <option value="all">Semua Kecamatan</option>
         <option value="Kecamatan1">Kecamatan Adian Koting</option>
         <option value="Kecamatan2">Kecamatan Garoga</option>
         <option value="Kecamatan3">Kecamatan Muara</option>
         <option value="Kecamatan3">Kecamatan Pagaran</option>
         <option value="Kecamatan3">Kecamatan Pahae Jae</option>
         <option value="Kecamatan3">Kecamatan Pahae Julu</option>
         <option value="Kecamatan3">Kecamatan Pangaribuan</option>
         <option value="Kecamatan3">Kecamatan Parmonangan</option>
         <option value="Kecamatan3">Kecamatan Purba Tua</option>
         <option value="Kecamatan3">Kecamatan Siatas Barita</option>
         <option value="Kecamatan3">Kecamatan Siborong Borong</option>
         <option value="Kecamatan3">Kecamatan Simangumban</option>
         <option value="Kecamatan3">Kecamatan Sipahutar</option>
         <option value="Kecamatan3">Kecamatan Sipoholon</option>
         <option value="Kecamatan3">Kecamatan Tarutung</option>
       </select>
     </div>
   </div>
   
   
   <div class="row" id="komoditasContainer">
     <div class="col-md-4 ftco-animate" data-kecamatan="Kecamatan1">
         <div class="project-wrap">
             <a href="#" class="img" style="background-image: url(images/cabemerah.jpg);">
                 <!-- <span class="price">Rp.550/Kg</span> -->
             </a>
             <div class="text p-4">
                 <h3><a href="#">Cabai Merah</a></h3>
                 <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
             </div>
         </div>
     </div>
     
     <div class="col-md-4 ftco-animate" data-kecamatan="Kecamatan2">
         <div class="project-wrap">
             <a href="#" class="img" style="background-image: url(images/cabehijau.jpg);">

             </a>
             <div class="text p-4">
                 <h3><a href="#">Cabai Hijau</a></h3>
                 <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
             </div>
         </div>
     </div>
     
     <div class="col-md-4 ftco-animate" data-kecamatan="Kecamatan3">
         <div class="project-wrap">
             <a href="#" class="img" style="background-image: url(images/kentang.jpg);">

             </a>
             <div class="text p-4">
                 <h3><a href="#">Kentang</a></h3>
                 <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
             </div>
         </div>
     </div>

     <div class="col-md-4 ftco-animate" data-kecamatan="Kecamatan1">
         <div class="project-wrap">
             <a href="#" class="img" style="background-image: url(images/tomat.jpg);">

             </a>
             <div class="text p-4">
                 <h3><a href="#">Tomat</a></h3>
                 <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
             </div>
         </div>
     </div>

     <div class="col-md-4 ftco-animate" data-kecamatan="Kecamatan2">
         <div class="project-wrap">
             <a href="#" class="img" style="background-image: url(images/wortel.jpg);">

             </a>
             <div class="text p-4">
                 <h3><a href="#">Wortel</a></h3>
                 <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
             </div>
         </div>
     </div>

     <div class="col-md-4 ftco-animate" data-kecamatan="Kecamatan3">
         <div class="project-wrap">
             <a href="#" class="img" style="background-image: url(images/bawangmerah.jpg);">

             </a>
             <div class="text p-4">
                 <h3><a href="#">Bawang Merah</a></h3>
                 <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
             </div>
         </div>
     </div>

     <div class="col-md-4 ftco-animate" data-kecamatan="Kecamatan1">
         <div class="project-wrap">
             <a href="#" class="img" style="background-image: url(images/bawangputih.jpg);">

             </a>
             <div class="text p-4">
                 <h3><a href="#">Bawang Putih</a></h3>
                 <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
             </div>
         </div>
     </div>

     <div class="col-md-4 ftco-animate" data-kecamatan="Kecamatan2">
         <div class="project-wrap">
             <a href="#" class="img" style="background-image: url(images/andaliman.jpg);">

             </a>
             <div class="text p-4">
                 <h3><a href="#">Andaliman</a></h3>
                 <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
             </div>
         </div>
     </div>

     <div class="col-md-4 ftco-animate" data-kecamatan="Kecamatan2">
      <div class="project-wrap">
          <a href="#" class="img" style="background-image: url(images/bawangbombay.jpg);">
              <span class="price">Rp.550/Kg</span>
          </a>
          <div class="text p-4">
              <h3><a href="#">bawangbombay</a></h3>
              <p class="location"><span class="fa fa-map-marker"></span> Desa</p>
          </div>
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
document.getElementById('filterKecamatan').addEventListener('change', function() {
   let selectedKecamatan = this.value;
   let items = document.querySelectorAll('#komoditasContainer .col-md-4');
   
   items.forEach(item => {
       if (selectedKecamatan === 'all' || item.getAttribute('data-kecamatan') === selectedKecamatan) {
           item.style.display = 'block';
       } else {
           item.style.display = 'none';
       }
   });
});
</script>

@endsection