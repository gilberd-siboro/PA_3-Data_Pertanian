<!DOCTYPE html>
<html lang="en" class="light scroll-smooth group" data-layout="vertical" data-sidebar="light" data-sidebar-size="lg"
    data-mode="light" data-topbar="light" data-skin="default" data-navbar="sticky" data-content="fluid" dir="ltr">


<head>

    <meta charset="utf-8">
    <title>Sign In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <meta content="Minimal Admin & Dashboard Template" name="description">
    <meta content="StarCode Kh" name="author">

    <!-- App favicon -->
    <link rel="shortcut icon" href="assets/images/logopptsb.jpg">
    <!-- Layout config Js -->
    <script src="assets/js/layout.js"></script>
    <!-- Icons CSS -->

    <!-- StarCode CSS -->


    <link rel="stylesheet" href="assets/css/starcode2.css">
    <style>
        .warna {
            background-color: #EBEFF2;
        }

        .back {
            background-color: #EBEFF2;
        }

        .back1 {
            background-color: #EBEFF2;
        }

        .form {
            background-color: #ffffff;
            border-radius: 20px;
        }

        .custom-btn {
            background-color: #697988;
            /* Mengatur latar belakang menjadi transparan */
        }

        .custom-btn:hover,
        .custom-btn:focus,
        .custom-btn:active {
            background-color: #445c73;
            /* Menjaga latar belakang tetap transparan pada saat hover, fokus, dan aktif */
        }

        .centered-image {
            width: 100px;
            /* Atur lebar gambar */
            border-radius: 1rem;
            /* Radius border untuk gambar */
            margin: 0 auto;
            /* Membuat gambar berada di tengah */
            display: block;
            /* Menampilkan elemen sebagai blok */
        }
    </style>

</head>

<body class="font-public ">

    <div class="relative flex justify-center flex-col w-full overflow-hidden xl:flex-row  back">
        <div
            class="min-h-[calc(100vh_-_theme('spacing.4')_*_2)] mx-3 lg:w-[40rem] shrink-0 px-10 py-14 flex items-center justify-center m-4 bg-white rounded z-10 relative dark:bg-zink-700 dark:text-zink-100 md:mx-auto xl:mx-4 back1">
            <div class="flex flex-col w-full h-full form">

                <div class="my-auto">
                    <div class="lg:w-[20rem] mx-auto mt-10">
                        <img src="" alt="">
                    </div>
                    <div class="lg:w-[25rem] mx-auto">
                        <div class="mt-5 tab-content">
                            <div class="block tab-pane" id="emailLogin">
                                <form action="/login" method="POST" class="mt-10" id="signInForm">
                                    @csrf
                                    <!-- <div class="flex justify-center">
                                        <img style="height: 200px;width: 380px" src="#"
                                            alt="">
                                    </div> -->
                                    <div class="mb-3">
                                        <label for="username"
                                            class="inline-block mb-2 text-base font-medium">Username</label>
                                        <input type="text" id="username" name="username"
                                            class="form-input border-slate-200 dark:border-zink-500 focus:outline-none focus:border-custom-500 disabled:bg-slate-100 dark:disabled:bg-zink-600 disabled:border-slate-300 dark:disabled:border-zink-500 dark:disabled:text-zink-200 disabled:text-slate-500 dark:text-zink-100 dark:bg-zink-700 dark:focus:border-custom-800 placeholder:text-slate-400 dark:placeholder:text-zink-200"
                                            placeholder="Enter username">
                                    </div>
                                    <div class="mb-3">
                                        <label for="password"
                                            class="inline-block mb-2 text-base font-medium">Password</label>
                                        <input type="password" id="password" name="password"
                                            class="form-input border-slate-200 dark:border-zink-500 focus:outline-none focus:border-custom-500 disabled:bg-slate-100 dark:disabled:bg-zink-600 disabled:border-slate-300 dark:disabled:border-zink-500 dark:disabled:text-zink-200 disabled:text-slate-500 dark:text-zink-100 dark:bg-zink-700 dark:focus:border-custom-800 placeholder:text-slate-400 dark:placeholder:text-zink-200"
                                            placeholder="Enter password">

                                    </div>
                                    <div class="mt-10 ">
                                        <button type="submit"
                                        class="w-full text-white btn bg-custom-500 border-custom-500 hover:text-white hover:bg-custom-600 hover:border-custom-600 focus:text-white focus:bg-custom-600 focus:border-custom-600 focus:ring focus:ring-custom-100 active:text-white active:bg-custom-600 active:border-custom-600 active:ring active:ring-custom-100 dark:ring-custom-400/20">Sign
                                            In</button>
                                    </div>
                                </form>
                            </div>
                        </div>


                    </div>
                </div>
                <div class="mt-5">
                    <p class="mb-0 text-center text-15 text-slate-500 dark:text-zink-200">©
                        <script>
                            document.write(new Date().getFullYear())
                        </script> Dinas Pertanian. Crafted with <i class="text-red-500 ri-heart-fill"></i> by <a
                            href="#"
                            class="underline transition-all duration-200 ease-linear text-slate-800 dark:text-zink-50 hover:text-custom-500">Dinas Pertanian</a>
                    </p>
                </div>
            </div>
        </div>

    </div>

    <script src='assets/libs/choices.js/public/assets/scripts/choices.min.js'></script>
    <script src="assets/libs/%40popperjs/core/umd/popper.min.js"></script>
    <script src="assets/libs/tippy.js/tippy-bundle.umd.min.js"></script>
    <script src="assets/libs/simplebar/simplebar.min.js"></script>
    <script src="assets/libs/prismjs/prism.js"></script>
    <script src="assets/libs/lucide/umd/lucide.js"></script>
    <script src="assets/js/starcode.bundle.js"></script>
</body>

</html>
