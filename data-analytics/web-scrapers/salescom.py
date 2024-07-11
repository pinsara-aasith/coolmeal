# import requests
# import csv
# import re
# from bs4 import BeautifulSoup
# import os
# from datetime import date


# # Function to fetch HTML content from a URL
# def fetch_html(url):
#     try:
#         response = requests.get(url)
#         if response.status_code == 200:
#             return response.text
#         else:
#             print(f"Failed to retrieve HTML. Status code: {response.status_code}")
#             return None
#     except requests.RequestException as e:
#         print(f"Error fetching HTML: {e}")
#         return None


# if __name__ == "__main__":
#     url = "https://www.selinawamucii.com/insights/prices/sri-lanka"
#     html_content = fetch_html(url)
#     print(html_content)
from bs4 import BeautifulSoup

html_content = """
<body style="transform: none;"><div class="body-overlay-1"></div> 
    <div id="fb-root" class=" fb_reset"><div style="position: absolute; top: -10000px; width: 0px; height: 0px;"><div></div></div></div>
<script src="https://connect.facebook.net/en_GB/sdk.js?hash=156b66cac957cd0cb22c5c5e2f9bb7f3" async="" crossorigin="anonymous"></script><script async="" defer="" crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&amp;version=v13.0" nonce="eICHR4ub"></script>  
   
        <header class="header-area header-style-1 header-height-2">
            
            <div class="header-middle header-middle-ptb-1 d-none d-lg-block">
                <div class="container">
                    <div class="header-wrap">
                        <div class="logo logo-width-1">
                            <a href="/"><img src="images/logo.svg" alt="logo"></a>
                        </div>
                        <div class="header-right">
                            <div class="search-style-2">
                                <form action="/listing" method="get">
                                    <select name="maincat" class="select-active select2-hidden-accessible" data-select2-id="1" tabindex="-1" aria-hidden="true">
                                        <option value="" data-select2-id="3">All Categories</option>
                                        <option value="">Select</option><option value="8">Book Corner</option><option value="3">Fashion Corner</option><option value="4">Fruit Corner</option><option value="9">Furniture Corner</option><option value="1">Gift Corner</option><option value="6">Grocery Corner</option><option value="12">Home Garniture Corner</option><option value="11">Service Corner</option><option value="2">Shoe Corner</option><option value="7">Statues Corner</option><option value="10">Toys Corner</option><option value="5">Vegetable Corner</option><option value="13">Vehicle Care Corner</option>                                    </select><span class="select2 select2-container select2-container--default" dir="ltr" data-select2-id="2" style="width: 140px;"><span class="selection"><span class="select2-selection select2-selection--single" role="combobox" aria-haspopup="true" aria-expanded="false" tabindex="0" aria-labelledby="select2-maincat-j6-container"><span class="select2-selection__rendered" id="select2-maincat-j6-container" role="textbox" aria-readonly="true" title="All Categories">All Categories</span><span class="select2-selection__arrow" role="presentation"><b role="presentation"></b></span></span></span><span class="dropdown-wrapper" aria-hidden="true"></span></span>
                                    <input type="text" name="keywords" value="" placeholder="Search for items...">
                                    <button>Search</button>
                                </form>
                            </div>
                            <div class="header-action-right">
                                <div class="header-action-2">                          
                                    
                                    <div class="header-action-icon-2">
                                        <a href="/dashboard?menu=wishlist">
                                            <img class="svgInject" alt="Nest" src="assets/imgs/theme/icons/icon-heart.svg">
                                            <span class="pro-count blue">0</span>
                                        </a>
                                        <a href="/dashboard?menu=wishlist"><span class="lable">Wishlist</span></a>
                                    </div>
                                    <div class="header-action-icon-2">
                                        <a class="mini-cart-icon" href="/cart">
                                            <img alt="" src="assets/imgs/theme/icons/icon-cart.svg">
                                            <span class="pro-count blue">0</span>
                                        </a>
                                        <a href="/cart"><span class="lable">Cart</span></a>    

                                        
                                    </div>                                    
                                    </div>
                                    <div class="header-action-icon-2">

                                                                                    <a href="/login">
                                                <img class="svgInject" alt="Nest" src="assets/imgs/theme/icons/icon-user.svg">
                                            </a>
                                            <a href="/login"><span class="lable ml-0">Login</span></a>
                                                                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            
            <div class="header-bottom header-bottom-bg-color sticky-bar">
                <div class="container">
                    <div class="header-wrap header-space-between position-relative">
                        <div class="logo logo-width-1 d-block d-lg-none">
                            <a href="/"><img src="images/logo-mobile.png" alt="logo"></a>
                        </div>
                        <div class="header-nav d-none d-lg-flex">
                            <div class="main-categori-wrap d-none d-lg-block">
                                <a class="categories-button-active" href="#">
                                    <span class="fi-rs-apps"></span> <span class="et">Browse</span> All Categories
                                    <i class="fi-rs-angle-down"></i>
                                </a>
                                <div class="categories-dropdown-wrap categories-dropdown-active-large font-heading">
                                    <div class="d-flex categori-dropdown-inner">
                                        <ul>
                                            
                                                    <li>
                                                        <a href="/listing?maincat=13"> Vehicle Care Corner (35)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=12"> Home Garniture Corner (0)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=11"> Service Corner (0)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=10"> Toys Corner (0)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=9"> Furniture Corner (0)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=8"> Book Corner (1)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=7"> Statues Corner (0)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=6"> Grocery Corner (551)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=5"> Vegetable Corner (32)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=4"> Fruit Corner (17)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=3"> Fashion Corner (3)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=2"> Shoe Corner (0)</a>
                                                    </li>
                                                    <li>
                                                        <a href="/listing?maincat=1"> Gift Corner (26)</a>
                                                    </li>                                            
                                        </ul>                                        
                                    </div>     
                                </div>
                            </div>
                            <div class="main-menu main-menu-padding-1 main-menu-lh-2 d-none d-lg-block font-heading">
                                <nav>
                                    <ul>                                        
                                        <li>
                                            <a href="/">Home</a>
                                        </li>
                                        <li>
                                            <a href="/about-us">About Us</a>
                                        </li> 
                                        <li>
                                            <a href="/listing">All Products</a>
                                        </li> 
                                        <li>
                                            <a href="/contact-us">Contact Us</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <div class="hotline d-none d-lg-flex">
                            <img src="assets/imgs/theme/icons/icon-headphone.svg" alt="hotline">
                            <p>+94772838351<span> Hotline</span></p>
                        </div>
                        <div class="header-action-icon-2 d-block d-lg-none">
                            <div class="burger-icon burger-icon-white">
                                <span class="burger-icon-top"></span>
                                <span class="burger-icon-mid"></span>
                                <span class="burger-icon-bottom"></span>
                            </div>
                        </div>
                        <div class="header-action-right d-block d-lg-none">
                            <div class="header-action-2">
                                <div class="header-action-icon-2">
                                    <a href="/dashboard?menu=wishlist">
                                        <img alt="Cart" src="assets/imgs/theme/icons/icon-heart.svg">
                                        <span class="pro-count white">0</span>
                                    </a>
                                </div>
                                <div class="header-action-icon-2">

                                    <a class="mini-cart-icon" href="/checkout">
                                        <img alt="Cart" src="assets/imgs/theme/icons/icon-cart.svg">
                                        <span class="pro-count white">0</span>
                                    </a>

                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div class="mobile-header-active mobile-header-wrapper-style">
            <div class="mobile-header-wrapper-inner">
                <div class="mobile-header-top">
                    <div class="mobile-header-logo">
                        <a href="/"><img src="images/logo.svg" alt="logo"></a>
                    </div>
                    <div class="mobile-menu-close close-style-wrap close-style-position-inherit">
                        <button class="close-style search-close">
                            <i class="icon-top"></i>
                            <i class="icon-bottom"></i>
                        </button>
                    </div>
                </div>
                <div class="mobile-header-content-area">
                    <div class="mobile-search search-style-3 mobile-header-border">
                       <form action="/listing" method="get">
                            <input type="text" name="keywords" value="" placeholder="Search for items…">
                            <button type="submit"><i class="fi-rs-search"></i></button>
                        </form>
                    </div>
                    <div class="mobile-menu-wrap mobile-header-border">
                        <nav>
                            <ul class="mobile-menu font-heading">
                                <li><a href="/">Home</a></li> 
                                <li><a href="/about-us">About Us</a></li> 
                                <li><a href="/listing">All Products</a></li> 
                                <li><a href="/contact-us">Contact Us</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="mobile-header-info-wrap">
                        <div class="single-mobile-header-info">
                            <a href="page-contact.html"><i class="fi-rs-marker"></i>No 152/B, Bakery Road, Alubomulla, Panadura, Sri lanka. </a>
                        </div>
                        <div class="single-mobile-header-info">
                            <a href="login"><i class="fi-rs-user"></i>Log In / Sign Up </a>
                        </div>
                        <div class="single-mobile-header-info">
                            <a href="#"><i class="fi-rs-headphones"></i><span>+94772838351 </span> <span class="">/ +94729778000</span></a>
                        </div>
                    </div>
                    <div class="mobile-social-icon mb-50">
                        <h6 class="mb-15">Follow Us</h6>
                        <a href="#"><img src="assets/imgs/theme/icons/icon-facebook-white.svg" alt=""></a>
                        <a href="#"><img src="assets/imgs/theme/icons/icon-twitter-white.svg" alt=""></a>
                        <a href="#"><img src="assets/imgs/theme/icons/icon-instagram-white.svg" alt=""></a>
                        <a href="#"><img src="assets/imgs/theme/icons/icon-pinterest-white.svg" alt=""></a>
                        <a href="#"><img src="assets/imgs/theme/icons/icon-youtube-white.svg" alt=""></a>
                    </div>
                    <div class="site-copyright">Copyright 2021 © . All rights reserved.</div>
                </div>
            </div>
        </div>

<main class="main" style="transform: none;">
    <div class="page-header breadcrumb-wrap">
        <div class="container">
            <div class="breadcrumb">
                <a href="/" rel="nofollow"><i class="fi-rs-home mr-5"></i>Home</a>
                <span></span>  <a href="/listing?id=4">Fruit Corner</a> <span></span> Lime             </div>
        </div>
    </div>
    <div class="container mb-30" style="transform: none;">
        <div class="row" style="transform: none;">
            <div class="col-xl-11 col-lg-12 m-auto" style="transform: none;">
                <div class="row" style="transform: none;">
                    <div class="col-xl-9">

                    	 <div class="product-detail accordion-detail">
                            <div class="row mb-50 mt-30">
                    	                       
                                <div class="col-md-6 col-sm-12 col-xs-12 mb-md-0 mb-sm-5">
                                	
<div class="detail-gallery">
    <span class="zoom-icon"><i class="fi-rs-search"></i></span>
    
    <div class="product-image-slider slick-initialized slick-slider">
        
                    <div class="slick-list draggable"><div class="slick-track" style="opacity: 1; width: 335px; transform: translate3d(0px, 0px, 0px);"><figure class="border-radius-10 slick-slide slick-current slick-active" data-slick-index="0" aria-hidden="false" tabindex="0" style="width: 335px;">
                        <img src="https://salescom.lk/images/product_images/img_rwjtkcupnvagme7h.jpg" alt="product image">
                    </figure></div></div>                    
                         

        
    </div>
    
    <div class="slider-nav-thumbnails slick-initialized slick-slider">
    <div class="slick-list draggable"><div class="slick-track" style="opacity: 1; width: 89px; transform: translate3d(0px, 0px, 0px);"><div class="slick-slide slick-current slick-active" data-slick-index="0" aria-hidden="false" tabindex="0" style="width: 69px;"><img src="https://salescom.lk/images/product_images/img_rwjtkcupnvagme7h.jpg" alt="product image"></div></div></div>        
       
    </div>
</div>

                                </div>
                                <div class="col-md-6 col-sm-12 col-xs-12">
                                	<form method="post" action="/functions/add-to-cart">
                                    <div class="detail-info pr-30 pl-30">
                                        <h2 class="title-detail">Lime</h2>
                                        
                                        
			<div class="clearfix product-price-cover price-box">
                <div class="product-price primary-color float-left">
                    <span class="current-price text-brand">Rs<span>. 700</span></span>
                    <span>
                </span></div>
            </div>
		                                        
                                        <div class="attr-detail attr-size mb-30">
                                            <strong class="mr-10">Option: </strong>
                                            <hr>
                                            <div class="product-single-filter">								
												<select class="select_models" name="select_models" id="select_models" required="">
												<option value="0,614">Select Option</option>										
												<option value="153,614">100g</option><option value="154,614">250g</option><option value="155,614">500g</option><option selected="" value="156,614">1Kg</option>												</select>									
											</div>
                                		</div>

                                        <div class="detail-extralink mb-50">
                                            <div class="detail-qty border radius">
                                            	<input name="order_type" value="1" type="hidden">
                                                <input type="number" id="tonemax" name="order_qty" value="1" min="1" max="25" step="1" maxlength="2">
                                            </div>
                                            <div class="product-extra-link2">
                                                <button type="submit" class="button button-add-to-cart"><i class="fi-rs-shopping-cart"></i>Add to cart</button>
                                                <a id="add_to_wishlist" data-product_id="614" aria-label="Add To Wishlist" class="action-btn  hover-up" href="#"><i class="fi-rs-heart"></i></a>
                                            </div>
                                        </div>
                                        <script type="text/javascript">
                                        	function enforce_maxlength(event) {
												  var t = event.target;
												  if (t.hasAttribute('maxlength')) {
												    t.value = t.value.slice(0, t.getAttribute('maxlength'));
												  }
												 if(t.value>25){
												 	t.value = 25;
												 }
												  if(t.value==0){
												  	t.value = 1;
												  }
												}
												document.body.addEventListener('input', enforce_maxlength);
                                        </script>
                                        <div class="font-xs">
                                            <ul class="mr-50 float-start">
                                                <li class="mb-5">Category: <span class="text-brand">Fruit Corner</span></li>

                                                <li class="mb-5">Sub Category: <span class="text-brand">Fresh Fruits</span></li>

                                                <li class="mb-5">SKU:<span class="text-brand"> FR000006</span></li>                                 
                                            </ul>
                                            <ul class="float-start">                                            	
                                                <li class="mb-5">SKU:<span class="text-brand"> FR000006</span></li>    
                                                <li class="mb-5">In stock: <span class="text-brand"><span class="in_stock"><i class="fa fa-check-circle"></i> In Stock</span></span></li>
                                                                                            </ul>
                                        </div>
                                    </div>
                                	</form>
                                    <!-- Detail Info -->
                                </div>
                            </div>



                            <div class="product-info">
                                <div class="tab-style3">
                                    <ul class="nav nav-tabs text-uppercase">
                                        <li class="nav-item">
                                            <a class="nav-link active" id="Description-tab" data-bs-toggle="tab" href="#Description">Description</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content shop_info_tab entry-main-content">
                                        <div class="tab-pane fade show active" id="Description">    

                                            <p>Lime</p>

                                            
											<table class="table table-hover product_info_table">
							                    <thead>
							                      <tr>
							                        <th colspan="2">Product specification</th>
							                      </tr>
							                    </thead>
							                    <tbody>
							                    								                    </tbody>
							                </table>
							            	
                                        </div>
                                    </div>                                    
                                </div>
                                             </div>

                        </div>

                    </div>




                    <div class="col-xl-3 primary-sidebar sticky-sidebar mt-30" style="position: relative; overflow: visible; box-sizing: border-box; min-height: 1px;">
                        
                        
                                                
                    <div class="theiaStickySidebar" style="padding-top: 1px; padding-bottom: 1px; position: static; transform: none;"><div class="sidebar-widget new_products product-sidebar mb-30 p-30 bg-grey border-radius-10">
                            <h5 class="section-title style-1 mb-30">New products</h5>

                            

									<div class="single-post clearfix">
									<form method="post" action="/functions/add-to-cart">
		                                <div class="image">
		                                    <img src="https://salescom.lk/images/product_images/img_vus5yf9igm3je84o.jpg">
		                                </div>
		                                <div class="content pt-10">
		                                    <h5><a href="/product-details?type=1&amp;id=621">Amla Fruit</a></h5>
		                                    <p class="price mb-0 mt-5">
										</p><div class="price-box2">						
											<span class="product-price">Rs<span>. 100</span></span>
										</div>
									<p></p>
		                                    <input name="order_type" value="1" type="hidden">	
		                                    <input type="hidden" value="0,621" name="select_models">
            								<input name="order_qty" value="1" type="hidden">	                                    
		                                </div>
		                            </form>
		                            </div>
								

									<div class="single-post clearfix">
									<form method="post" action="/functions/add-to-cart">
		                                <div class="image">
		                                    <img src="https://salescom.lk/images/product_images/img_6dreyma9wf0bojkg.jpg">
		                                </div>
		                                <div class="content pt-10">
		                                    <h5><a href="/product-details?type=1&amp;id=624">Rambutan</a></h5>
		                                    <p class="price mb-0 mt-5">
										</p><div class="price-box2">						
											<span class="product-price">Rs<span>. 100</span></span>
										</div>
									<p></p>
		                                    <input name="order_type" value="1" type="hidden">	
		                                    <input type="hidden" value="0,624" name="select_models">
            								<input name="order_qty" value="1" type="hidden">	                                    
		                                </div>
		                            </form>
		                            </div>
								

									<div class="single-post clearfix">
									<form method="post" action="/functions/add-to-cart">
		                                <div class="image">
		                                    <img src="https://salescom.lk/images/product_images/img_ou9nz0dryc7vf1l5.jpg">
		                                </div>
		                                <div class="content pt-10">
		                                    <h5><a href="/product-details?type=1&amp;id=617">Duriyan</a></h5>
		                                    <p class="price mb-0 mt-5">
										</p><div class="price-box2">						
											<span class="product-price">Rs<span>. 100</span></span>
										</div>
									<p></p>
		                                    <input name="order_type" value="1" type="hidden">	
		                                    <input type="hidden" value="0,617" name="select_models">
            								<input name="order_qty" value="1" type="hidden">	                                    
		                                </div>
		                            </form>
		                            </div>
								

									<div class="single-post clearfix">
									<form method="post" action="/functions/add-to-cart">
		                                <div class="image">
		                                    <img src="https://salescom.lk/images/product_images/img_vn84khzl6gaefjb7.jpg">
		                                </div>
		                                <div class="content pt-10">
		                                    <h5><a href="/product-details?type=1&amp;id=620">Grape</a></h5>
		                                    <p class="price mb-0 mt-5">
										</p><div class="price-box2">						
											<span class="product-price">Rs<span>. 100</span></span>
										</div>
									<p></p>
		                                    <input name="order_type" value="1" type="hidden">	
		                                    <input type="hidden" value="0,620" name="select_models">
            								<input name="order_qty" value="1" type="hidden">	                                    
		                                </div>
		                            </form>
		                            </div>
								

									<div class="single-post clearfix">
									<form method="post" action="/functions/add-to-cart">
		                                <div class="image">
		                                    <img src="https://salescom.lk/images/product_images/img_b0ypm8ic6g47vfew.jpg">
		                                </div>
		                                <div class="content pt-10">
		                                    <h5><a href="/product-details?type=1&amp;id=616">Diul</a></h5>
		                                    <p class="price mb-0 mt-5">
										</p><div class="price-box2">						
											<span class="product-price">Rs<span>. 100</span></span>
										</div>
									<p></p>
		                                    <input name="order_type" value="1" type="hidden">	
		                                    <input type="hidden" value="0,616" name="select_models">
            								<input name="order_qty" value="1" type="hidden">	                                    
		                                </div>
		                            </form>
		                            </div>
								

									<div class="single-post clearfix">
									<form method="post" action="/functions/add-to-cart">
		                                <div class="image">
		                                    <img src="https://salescom.lk/images/product_images/img_xr1jelu2t7av3qcs.jpg">
		                                </div>
		                                <div class="content pt-10">
		                                    <h5><a href="/product-details?type=1&amp;id=612">Beli</a></h5>
		                                    <p class="price mb-0 mt-5">
										</p><div class="price-box2">						
											<span class="product-price">Rs<span>. 100</span></span>
										</div>
									<p></p>
		                                    <input name="order_type" value="1" type="hidden">	
		                                    <input type="hidden" value="0,612" name="select_models">
            								<input name="order_qty" value="1" type="hidden">	                                    
		                                </div>
		                            </form>
		                            </div>
								
                            
                        </div></div></div>
                </div>
            </div>
        </div>
    </div>
</main>

                <footer class="main">            
            <section class="featured section-padding">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-md-6 col-12 col-sm-6 mb-md-3 mb-xl-0">
                            <div class="banner-left-icon d-flex align-items-center wow animate__animated animate__fadeInUp" data-wow-delay="0" style="visibility: hidden; animation-name: none;">
                                <div class="banner-icon">
                                    <img src="assets/imgs/theme/icons/icon-1.svg" alt="">
                                </div>
                                <div class="banner-text">
                                    <h3 class="icon-box-title">Best prices &amp; offers</h3>
                                    <p>Affodable price</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-12 col-sm-6 mb-md-3 mb-xl-0">
                            <div class="banner-left-icon d-flex align-items-center wow animate__animated animate__fadeInUp" data-wow-delay=".1s" style="visibility: hidden; animation-delay: 0.1s; animation-name: none;">
                                <div class="banner-icon">
                                    <img src="assets/imgs/theme/icons/icon-2.svg" alt="">
                                </div>
                                <div class="banner-text">
                                    <h3 class="icon-box-title">Fast delivery</h3>
                                    <p>24/7 amazing services</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-12 col-sm-6 mb-md-3 mb-xl-0">
                            <div class="banner-left-icon d-flex align-items-center wow animate__animated animate__fadeInUp" data-wow-delay=".2s" style="visibility: hidden; animation-delay: 0.2s; animation-name: none;">
                                <div class="banner-icon">
                                    <img src="assets/imgs/theme/icons/icon-3.svg" alt="">
                                </div>
                                <div class="banner-text">
                                    <h3 class="icon-box-title">Great daily deal</h3>
                                    <p>When you sign up</p>
                                </div>
                            </div>
                        </div>                        
                        <div class="col-lg-3 col-md-6 col-12 col-sm-6 mb-md-3 mb-xl-0">
                            <div class="banner-left-icon d-flex align-items-center wow animate__animated animate__fadeInUp" data-wow-delay=".5s" style="visibility: hidden; animation-delay: 0.5s; animation-name: none;">
                                <div class="banner-icon">
                                    <img src="assets/imgs/theme/icons/icon-6.svg" alt="">
                                </div>
                                <div class="banner-text">
                                    <h3 class="icon-box-title">Safe delivery</h3>
                                    <p>Within 3 working days</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <section class="section-padding delivery-areas">
                 <div class="container">
                    <div class="bg-wrap">
                        <div class="section-title style-2 wow animate__ animate__fadeIn animated" style="visibility: hidden; animation-name: none;">
                            <h3>Our Delivery Areas</h3>                        
                        </div>
                        <ul class="row areawrap">
                        <li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Colombo</h5><h6>Nugegoda</h6><p>Nugegoda City (Rs.750.00)</p><h6>Piliyandala</h6><p>Piliyandala City (Rs.550.00)</p><h6>Maharagama</h6><p>Maharagama (Rs.750.00)</p><h6>Avissawella </h6><p>Avissawella City (Rs.750.00)</p><h6>Battaramulla </h6><p>Battaramulla City (Rs.750.00)</p><h6>Colombo 12</h6><p>Colombo 12 (Rs.750.00)</p><h6>Kesbewa </h6><p>Kesbewa City (Rs.550.00)</p><h6>Kotte </h6><p>Kotte City (Rs.750.00)</p><h6>Moratuwa </h6><p>Moratuwa City (Rs.750.00)</p><h6>Mount Lavinia </h6><p>Mount Lavinia City (Rs.750.00)</p><h6>Colombo</h6><p>Colombo City (Rs.750.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Kandy</h5><h6>Kandy</h6><p>Kandy City (Rs.700.00)</p><h6>Gampola</h6><p>Gampola City (Rs.750.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Galle</h5><h6>Galle</h6><p>Galle City (Rs.750.00)</p><h6>Ambalangoda</h6><p>Ambalangoda City (Rs.750.00)</p><h6>Hikkaduwa</h6><p>Hikkaduwa City (Rs.750.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Anuradhapura</h5><h6>Anuradhapura</h6><p>Anuradhapura City (Rs.700.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Badulla</h5><h6>Badulla</h6><p>Badulla City (Rs.750.00)</p><h6>Welimada</h6><p>Walimada City (Rs.700.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Gampaha</h5><h6>Gampaha</h6><p>Gampaha City (Rs.700.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Kalutara</h5><h6>Kalutara</h6><p>Kaluthara City (Rs.700.00)</p><h6>Panadura</h6><p>Panadura City (Rs.570.00)</p><p>Madupitiya &amp; Mahawila Area (Rs.375.00)</p><p>Arukgoda &amp; Mahabellana Area (Rs.350.00)</p><h6>Horana</h6><p>Horana City (Rs.750.00)</p><h6>Bandaragama</h6><p>Bandaragama City (Rs.550.00)</p><h6>Ingiriya </h6><p>Ingiriya City (Rs.750.00)</p><h6>Wadduwa </h6><p>Wadduwa City (Rs.650.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Kegalle</h5><h6>Kegalle</h6><p>Kegalle City (Rs.700.00)</p><h6>Mawanella</h6><p>Mawanella City (Rs.750.00)</p><h6>Galigamuwa </h6><p>Galigamuwa City (Rs.700.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Matale</h5><h6>Matale</h6><p>Matale City (Rs.700.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Matara</h5><h6>Matara</h6><p>Matara City (Rs.750.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Moneragala</h5><h6>Wellawaya</h6><p>Wellawaya City (Rs.750.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Nuwara Eliya</h5><h6>Nuwara Eliya</h6><p>Nuwara Eliya City (Rs.750.00)</p><p>Haguranketha City (Rs.750.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Puttalam</h5><h6>Puttalam</h6><p>Puttalam City (Rs.750.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Ratnapura</h5><h6>Kuruwita</h6><p>Kuruwita City (Rs.750.00)</p></li><li class="animate__animated animate__fadeInUp col-12 col-md-4 col-lg-2"><h5>Trincomalee</h5><h6>Trincomalee</h6><p>Trincomalee City (Rs.750.00)</p><h6>Kinniya</h6><p>Kinniya City (Rs.750.00)</p></li>                        </ul>
                    </div>
                </div>
            </section>
            <section class="section-padding footer-mid">
                <div class="container pt-15 pb-20">
                    <div class="row">
                        <div class="col">
                            <div class="widget-about font-md mb-md-3 mb-lg-3 mb-xl-0 wow animate__animated animate__fadeInUp" data-wow-delay="0" style="visibility: hidden; animation-name: none;">
                                <div class="logo mb-30">
                                    <a href="/" class="mb-15"><img src="images/logo.svg" alt="logo"></a>
                                    <p class="font-lg text-heading">Online Grocery Shopping has become easy with Salescom. We are offering online grocery delivery.</p>
                                    <p><strong>BR Number : WLL-7226</strong></p>
                                </div>
                                
                            </div>
                        </div>
                        <div class="footer-link-widget col footer-two-col-wrap col-lg-3 wow animate__animated animate__fadeInUp" data-wow-delay=".1s" style="visibility: hidden; animation-delay: 0.1s; animation-name: none;">
                        <div class="footer-two-col">
                            <h4 class="widget-title">Salescom</h4>
                            <ul class="footer-list mb-sm-5 mb-md-0">
                                <li><a href="/about-us">About Us</a></li>
                                <li><a href="/contact-us">Contact Us</a></li>
                                <!--<li><a href="/terms-and-onditions">Terms &amp; Conditions</a></li>-->
                            </ul>
                        </div>
                        <div class="footer-two-col">
                            <h4 class="widget-title">Information</h4>
                            <ul class="footer-list mb-sm-5 mb-md-0">
                                <li><a href="/delivery-information">Delivery Information</a></li>
                                <li><a href="/privacy-policy">Privacy Policy</a></li>
                                <li><a href="/return-policy">Return Policy</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="footer-link-widget col wow animate__animated animate__fadeInUp" data-wow-delay=".2s" style="visibility: hidden; animation-delay: 0.2s; animation-name: none;">
                        <h4 class="widget-title">Account</h4>
                        <ul class="footer-list mb-sm-5 mb-md-0">
                            <li><a href="/register">Register</a></li>
                            <li><a href="/login">Sign In</a></li>
                            <li><a href="/cart">View Cart</a></li>
                            <li><a href="/wishlist">My Wishlist</a></li>
                            <li><a href="/dashboard">Dashboard</a></li>
                        </ul>
                    </div>                    
                    <div class="footer-link-widget col wow animate__animated animate__fadeInUp" data-wow-delay=".4s" style="visibility: hidden; animation-delay: 0.4s; animation-name: none;">
                        <h4 class="widget-title">Find Us On Facebook</h4>
                        <div class="fb-page fb_iframe_widget" data-href="https://www.facebook.com/Salescomlk-107873418176262" data-tabs="" data-width="" data-height="" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="false" fb-xfbml-state="rendered" fb-iframe-plugin-query="adapt_container_width=true&amp;app_id=&amp;container_width=171&amp;hide_cover=false&amp;href=https%3A%2F%2Fwww.facebook.com%2FSalescomlk-107873418176262&amp;locale=en_GB&amp;sdk=joey&amp;show_facepile=false&amp;small_header=false&amp;tabs=&amp;width="><span style="vertical-align: bottom; width: 180px; height: 130px;"><iframe name="f5eb9b12222f0a0d1" width="1000px" height="1000px" data-testid="fb:page Facebook Social Plugin" title="fb:page Facebook Social Plugin" frameborder="0" allowtransparency="true" allowfullscreen="true" scrolling="no" allow="encrypted-media" src="https://www.facebook.com/v13.0/plugins/page.php?adapt_container_width=true&amp;app_id=&amp;channel=https%3A%2F%2Fstaticxx.facebook.com%2Fx%2Fconnect%2Fxd_arbiter%2F%3Fversion%3D46%23cb%3Dfe25bd06999162b84%26domain%3Dsalescom.lk%26is_canvas%3Dfalse%26origin%3Dhttps%253A%252F%252Fsalescom.lk%252Ff195d2735a654736c%26relation%3Dparent.parent&amp;container_width=171&amp;hide_cover=false&amp;href=https%3A%2F%2Fwww.facebook.com%2FSalescomlk-107873418176262&amp;locale=en_GB&amp;sdk=joey&amp;show_facepile=false&amp;small_header=false&amp;tabs=&amp;width=" style="border: none; visibility: visible; width: 180px; height: 130px;" class=""></iframe></span></div>
                    </div>
                    <div class="footer-link-widget widget-install-app col wow animate__animated animate__fadeInUp" data-wow-delay=".5s" style="visibility: hidden; animation-delay: 0.5s; animation-name: none;">
                        <h4 class="widget-title">Contact Us</h4>
                        <ul class="contact-infor">
                            <li><img src="assets/imgs/theme/icons/icon-location.svg" alt=""><div class="con-wrap"><strong>Address: </strong> <span>No 152/B, Bakery Road, Alubomulla, Panadura, Sri lanka.</span></div></li>
                            <li><img src="assets/imgs/theme/icons/icon-contact.svg" alt=""><div class="con-wrap"><strong>Call Us: </strong><span> +94772838351</span></div></li>
                            <li><img src="assets/imgs/theme/icons/icon-contact.svg" alt=""><div class="con-wrap"><strong>Call Us: </strong><span class="">+94729778000</span></div></li>
                            <li><img src="assets/imgs/theme/icons/icon-email-2.svg" alt=""><strong>Email:</strong><span><a href="salescomlk@gmail.com">salescomlk@gmail.com</a></span></li>
                        </ul>
                        <p class="mb-5 mt-20 font-weight-bold">Secured Payment Gateways</p>
                        <img class="" src="assets/imgs/theme/payment-method.png" alt="">
                    </div>
                </div>
            </div></section>
            <div class="container pb-30 wow animate__animated animate__fadeInUp" data-wow-delay="0" style="visibility: hidden; animation-name: none;">
                <div class="row align-items-center">
                    <div class="col-12 mb-30">
                        <div class="footer-bottom"></div>
                    </div>
                    <div class="col-xl-8 col-lg-6 col-md-6">
                        <p class="font-sm mb-0">© 2022, <strong class="text-brand">Salecom.lk</strong> - Web Design By Web Design Sri Lanka. All rights reserved</p>
                    </div>                    
                    <div class="col-xl-4 col-lg-6 col-md-6 text-end d-none d-md-block">
                        <div class="mobile-social-icon">
                            <h6>Follow Us</h6>
                            <a target="_blank" href="https://www.facebook.com/Salescomlk-107873418176262/"><img src="assets/imgs/theme/icons/icon-facebook-white.svg" alt=""></a>
                            <a href="#"><img src="assets/imgs/theme/icons/icon-twitter-white.svg" alt=""></a>
                            <a href="https://www.instagram.com/salescom_lk?r=nametag"><img src="assets/imgs/theme/icons/icon-instagram-white.svg" alt=""></a>
                            <a href="#"><img src="assets/imgs/theme/icons/icon-pinterest-white.svg" alt=""></a>
                            <a href="#"><img src="assets/imgs/theme/icons/icon-youtube-white.svg" alt=""></a>
                        </div>
                        
                    </div>
                </div>
            </div>
        </section></footer>

        <div class="global_message">
            
        </div>

        <script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/vendor/modernizr-3.6.0.min.js"></script>
        <script src="assets/js/vendor/jquery-3.6.0.min.js"></script>
        <script src="assets/js/vendor/jquery-migrate-3.3.0.min.js"></script>
        <script src="assets/js/vendor/bootstrap.bundle.min.js"></script>
        <script src="assets/js/plugins/slick.js"></script>
        <script src="assets/js/plugins/jquery.syotimer.min.js"></script>
        <script src="assets/js/plugins/waypoints.js"></script>
        <script src="assets/js/plugins/wow.js"></script>
        <script src="assets/js/plugins/perfect-scrollbar.js"></script>
        <script src="assets/js/plugins/magnific-popup.js"></script>
        <script src="assets/js/plugins/select2.min.js"></script>
        <script src="assets/js/plugins/counterup.js"></script>
        <script src="assets/js/plugins/jquery.countdown.min.js"></script>
        <script src="assets/js/plugins/images-loaded.js"></script>
        <script src="assets/js/plugins/isotope.js"></script>
        <script src="assets/js/plugins/scrollup.js"></script>
        <script src="assets/js/plugins/jquery.vticker-min.js"></script>
        <script src="assets/js/plugins/jquery.theia.sticky.js"></script>
        <script src="assets/js/plugins/jquery.elevatezoom.js"></script>
        <script src="https://unpkg.com/micromodal/dist/micromodal.min.js"></script>

        <!-- Template  JS -->
        <script src="assets/js/main.js?v=4.1"></script><a id="scrollUp" href="#top" style="display: none; position: fixed; z-index: 2147483647;"><i class="fi-rs-arrow-small-up"></i></a>
        <script src="assets/js/shop.js?v=4.1"></script>





    
<div class="zoomContainer" style="-webkit-transform: translateZ(0);position:absolute;left:100.4000015258789px;top:179.9250030517578px;height:252.637px;width:335px;"><div class="zoomWindowContainer" style="width: 400px;"><div style="z-index: 999; overflow: hidden; margin-left: 0px; margin-top: 0px; background-position: 0px 0px; width: 335px; height: 252.637px; float: left; display: none; cursor: crosshair; background-repeat: no-repeat; position: absolute; background-image: url(&quot;https://salescom.lk/images/product_images/img_rwjtkcupnvagme7h.jpg&quot;);" class="zoomWindow">&nbsp;</div></div></div></body>
"""

# Parse the HTML content
soup = BeautifulSoup(html_content, "html.parser")

# Find the <div> element with the specified class
price_div = soup.find("div", class_="product-price primary-color float-left")

# Find the span with the class 'current-price text-brand'
price_span = price_div.find("span", class_="current-price text-brand")

# Extract the price text, combining nested spans
price_text = price_span.text.strip().replace("\n", "")

print("Price ", price_text)

# Parse the HTML content
soup = BeautifulSoup(html_content, "html.parser")

# Find the <select> element by its ID
select_element = soup.find("select", {"id": "select_models"})

# Find the selected <option> within the <select> element
selected_option = select_element.find("option", selected=True)

# Get the text of the selected option
selected_weight = selected_option.text

print("Selected Weight : ", selected_weight)
