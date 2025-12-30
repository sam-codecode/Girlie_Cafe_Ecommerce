<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Home | Girlie’s Café</title>

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Dancing+Script:wght@400;500;600;700&family=Lora:wght@400;500;600;700&family=Quicksand:wght@400;500;600;700&family=Cormorant+Garamond:wght@400;500;600;700&family=Libre+Baskerville:wght@400;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">

  <!-- HOME CSS (your given path) -->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/home.css">
  <!-- Swiper (CDN) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
  

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body>

<!-- =========================
     TOP HERO + NAV
========================== -->
<header class="top-hero">

  <nav class="top-navi">
    <!-- Brand -->
    <a class="brand" href="<%= request.getContextPath() %>/user/index.jsp">
      <img src="<%= request.getContextPath() %>/assets/images/logo.png" class="brand-logo" alt="Girlie’s Café">
      <span class="brand-name">Girlie’s Café</span>
    </a>

    <!-- Nav Links -->
    <div class="navi-links">
      <a class="navi-link active" href="<%= request.getContextPath() %>/user/index.jsp">Home</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/products">Menu</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/cart.jsp">Cart</a>
     <a class="navi-link" href="<%= request.getContextPath() %>/orderHistory">
    My History
</a>

    </div>

    <!-- CTA -->
    <a class="nav-cta pop-effect" href="<%= request.getContextPath() %>/user/cart.jsp">Checkout</a>
  </nav>

  <!-- =========================
       NEW YEAR PROMO
  ========================== -->
  <section class="ny-promo">
    <div class="ny-card">

      <div class="ny-title-wrap">
        <p class="ny-kicker">Happy New Year</p>
        <h1 class="ny-year">2026</h1>
      </div>

      <div class="ny-content">
        <h2 class="ny-headline">New Year Specials ✨</h2>
        <p class="ny-subline">Enjoy exclusive rewards when you dine with us this festive season.</p>

        <ul class="ny-list">
          <li>🍰 <b>RM30+</b> — Complimentary dessert and drink</li>
          <li>🎁 <b>RM50+</b> — 10% discount on total bill</li>
        </ul>

        <p class="ny-valid">🎊 Promo valid till <b>31st JANUARY 2026</b> — come &amp; grab it!</p>
      </div>

    </div>
  </section>

</header>

<!-- =========================
     ABOUT US
========================== -->
<section class="section about-section">
  <div class="wrap about-grid">

    <div class="about-left">
      <h2 class="section-title">About Us</h2>

      <p class="section-text">
        At <b>Girlie’s Café</b>, located in the heart of Ipoh town, we’ve been serving comforting food and warm vibes since 2015.
        What began as a small café along Jalan Market has grown into a favourite spot for locals who love good food
        and a cozy atmosphere.
      </p>

      <p class="section-text">
        Our menu features cozy brunch favourites, Western delights, pasta &amp; rice bowls, indulgent desserts,
        and handcrafted beverages — all prepared with care using quality ingredients.
        From our signature Tonkatsu Rice to our popular desserts and drinks, every dish is designed to feel like
        a warm hug, soft vibes, cute plating, and good food.
      </p>

      <a class="explore-btn pop-effect" href="<%= request.getContextPath() %>/products">
        Explore the Menu →
      </a>
    </div>

    <div class="about-right">
      <div class="why-card">
        <h3 class="why-title">Why Our Guests Love Us 💗</h3>
        <ul class="why-list">
          <li>✨ A cozy, aesthetic setting in a convenient location</li>
          <li>😊 Friendly and attentive service that feels welcoming</li>
          <li>🎶 A calm atmosphere with soft background music</li>
          <li>🍽️ Well-priced, delicious dishes without compromising on quality</li>
        </ul>

        <div class="stats">
          <div class="stat">
            <div class="stat-big">4.8★</div>
            <div class="stat-small">Customer Rating</div>
          </div>
          <div class="stat">
            <div class="stat-big">40+</div>
            <div class="stat-small">Menu Items</div>
          </div>
          <div class="stat">
            <div class="stat-big">Daily</div>
            <div class="stat-small">Fresh Bakes</div>
          </div>
        </div>
      </div>
    </div>

  </div>
</section>

<!-- =========================
     SECTION 3: CAFÉ HIGHLIGHTS
========================== -->
<section class="fav-section" id="highlights">
  <div class="fav-overlay">
    <div class="wrap fav-wrap">

      <div class="fav-head">
        <h2 class="fav-title">Café Highlights</h2>
        <p class="fav-subtitle">Handpicked favourites from our kitchen✨</p>
      </div>

<div class="swiper favSwiper">
  <div class="swiper-wrapper">

    <div class="swiper-slide">
      <article class="fav-card">
        <img class="fav-img"
             src="<%= request.getContextPath() %>/assets/images/topfav/parmigiana.png"
             alt="Chicken Parmigiana">
        <div class="fav-body">
          <h3>Chicken Parmigiana</h3>
          <p>Crispy chicken with marinara, melted cheese &amp; fresh salad.</p>
          <div class="fav-price">Price: RM 23.00</div>
          <a class="view-btn" href="<%= request.getContextPath() %>/user/product_details.jsp">View Details</a>
        </div>
      </article>
    </div>

    <div class="swiper-slide">
      <article class="fav-card">
        <img class="fav-img"
             src="<%= request.getContextPath() %>/assets/images/topfav/truffle.png"
             alt="Truffle Carbonara">
        <div class="fav-body">
          <h3>Truffle Carbonara</h3>
          <p>Creamy carbonara with parmesan, truffle aroma &amp; crispy bacon.</p>
          <div class="fav-price">Price: RM 25.00</div>
          <a class="view-btn" href="<%= request.getContextPath() %>/user/product_details.jsp">View Details</a>
        </div>
      </article>
    </div>

    <div class="swiper-slide">
      <article class="fav-card">
        <img class="fav-img"
             src="<%= request.getContextPath() %>/assets/images/topfav/tonkatsu.png"
             alt="Tonkatsu Rice">
        <div class="fav-body">
          <h3>Tonkatsu Rice</h3>
          <p>Crispy chicken cutlet with Japanese sauce, rice &amp; fresh salad.</p>
          <div class="fav-price">Price: RM 19.00</div>
          <a class="view-btn" href="<%= request.getContextPath() %>/user/product_details.jsp">View Details</a>
        </div>
      </article>
    </div>

    <div class="swiper-slide">
      <article class="fav-card">
        <img class="fav-img"
             src="<%= request.getContextPath() %>/assets/images/topfav/lava-cake.png"
             alt="Chocolate Lava Cake">
        <div class="fav-body">
          <h3>Chocolate Lava Cake</h3>
          <p>Warm chocolate cake with molten centre.</p>
          <div class="fav-price">Price: RM 10.00</div>
          <a class="view-btn" href="<%= request.getContextPath() %>/user/product_details.jsp">View Details</a>
        </div>
      </article>
    </div>

    <div class="swiper-slide">
      <article class="fav-card">
        <img class="fav-img"
             src="<%= request.getContextPath() %>/assets/images/topfav/latte.png"
             alt="Iced Lotus Latte">
        <div class="fav-body">
          <h3>Iced Lotus Latte</h3>
          <p>Chilled latte blended with sweet Lotus Biscoff flavour.</p>
          <div class="fav-price">Price: RM 12.00</div>
          <a class="view-btn" href="<%= request.getContextPath() %>/user/product_details.jsp">View Details</a>
        </div>
      </article>
    </div>

  </div>

  <!-- arrows + dots -->
  <div class="swiper-button-prev fav-swiper-prev"></div>
  <div class="swiper-button-next fav-swiper-next"></div>
  <div class="swiper-pagination fav-swiper-pagination"></div>
</div>


    </div>
  </div>
</section>

<!-- =========================
     SECTION 4: SERVICES
========================== -->
<section class="section services-section">
  <div class="wrap">

    <div class="services-head">
      <h2 class="section-title">How You Can Enjoy With Us✨</h2>
      <p class="section-subtext">
        Dine in, reserve ahead, or enjoy our food from the comfort of your home.
      </p>
    </div>

    <div class="services-grid">

      <div class="service-card pop-effect">
        <div class="service-icon">🍽️</div>
        <h3 class="service-title">Order In Restaurant</h3>
        <p class="service-text">Enjoy freshly prepared food with our cozy ambience.</p>
        <p class="service-meta">No waiting • Freshly cooked</p>
        <a class="service-link" href="<%= request.getContextPath() %>/products">
          Browse Menu →
        </a>
      </div>

      <div class="service-card pop-effect">
        <div class="service-icon">📱</div>
        <h3 class="service-title">Reserve Table (WhatsApp)</h3>
        <p class="service-text">Book your seat in seconds via WhatsApp.</p>
        <p class="service-meta">Instant reply • No calls needed</p>
        <a class="service-link" href="https://wa.me/60123456789" target="_blank" rel="noopener">
          Reserve Now →
        </a>
      </div>

      <div class="service-card pop-effect">
        <div class="service-icon">🚚</div>
        <h3 class="service-title">Delivery</h3>
        <p class="service-text">Quick delivery for cravings at home or office.</p>
        <p class="service-meta">Fast • Carefully packed</p>
        <a class="service-link" href="<%= request.getContextPath() %>/products">
          Order Now →
        </a>
      </div>

    </div>

  </div>
</section>

<!-- =========================
     SECTION: MEET OUR TEAM (SLIDER)
========================== -->
<section class="team-section" id="ourTeam">
  <div class="team-overlay">

    <div class="wrap team-wrap">

      <div class="team-head">
        <h2 class="team-title">Meet Our Team</h2>
        <p class="team-subtitle">The people behind your cozy café moments ☕</p>
      </div>

<div class="swiper teamSwiper">
  <div class="swiper-wrapper">

    <div class="swiper-slide">
      <article class="team-card">
        <img class="team-img" src="<%= request.getContextPath() %>/assets/images/team/samuel.jpeg" alt="Samuel">
        <div class="team-body">
          <div class="team-info-box">
            <div class="team-role">Café Founder</div>
            <h3 class="team-name">Samuel Raj</h3>
            <p class="team-desc">The café founder brings ideas to life by shaping the vision and identity of the café. He focus on creating a cozy atmosphere and meaningful moments that make guests feel at home.</p>
            <div class="team-tags">
              <span class="team-tag">Visionary</span>
              <span class="team-tag">Espresso</span>
            </div>
          </div>
        </div>
      </article>
    </div>

    <div class="swiper-slide">
      <article class="team-card">
        <img class="team-img" src="<%= request.getContextPath() %>/assets/images/team/menakha.png" alt="Menakha">
        <div class="team-body">
          <div class="team-info-box">
            <div class="team-role">Café Operations Manager</div>
            <h3 class="team-name">Menakha</h3>
            <p class="team-desc">The café operations manager ensures that everything runs smoothly behind the scenes. They maintain consistency and efficiency so every customer enjoys a relaxed experience.</p>
            <div class="team-tags">
              <span class="team-tag">Problem Solver</span>
              <span class="team-tag">Cold Brew</span>
            </div>
          </div>
        </div>
      </article>
    </div>

    <div class="swiper-slide">
      <article class="team-card">
        <img class="team-img" src="<%= request.getContextPath() %>/assets/images/team/venmadhi.png" alt="Venmadhi">
        <div class="team-body">
          <div class="team-info-box">
            <div class="team-role">Creative Director</div>
            <h3 class="team-name">Venmadhi</h3>
            <p class="team-desc">The creative director shapes the look and feel of the café through thoughtful design and details. They create warm, inviting experiences that reflect the café’s personality and charm.</p>
            <div class="team-tags">
              <span class="team-tag">Creative Mind</span>
              <span class="team-tag">Frappe</span>
            </div>
          </div>
        </div>
      </article>
    </div>

    <div class="swiper-slide">
      <article class="team-card">
        <img class="team-img" src="<%= request.getContextPath() %>/assets/images/team/anunitha.png" alt="Anunitha">
        <div class="team-body">
          <div class="team-info-box">
            <div class="team-role">Strategy Director</div>
            <h3 class="team-name">Anunitha</h3>
            <p class="team-desc">The strategy director plans thoughtful ideas that support the café’s growth and direction. They focus on long-term success while staying true to the café’s core values.</p>
            <div class="team-tags">
              <span class="team-tag">Forward Thinker</span>
              <span class="team-tag">Cakes</span>
            </div>
          </div>
        </div>
      </article>
    </div>

  </div>

  <!-- arrows + dots -->
  <div class="swiper-button-prev team-swiper-prev"></div>
  <div class="swiper-button-next team-swiper-next"></div>
  <div class="swiper-pagination team-swiper-pagination"></div>
</div>

  </div>
</section>


<!-- =========================
     FOOTER
========================== -->
<footer class="footer">
  <div class="wrap footer-grid">

    <div class="footer-col">
      <div class="footer-brand">Girlie’s Café</div>
      <p class="footer-text">
        <strong>Operating Hours</strong><br>
        Monday – Saturday: 8:00 AM – 7:00 PM<br>
        Sunday &amp; Public Holidays: Closed
      </p>
    </div>

    <div class="footer-col">
      <div class="footer-title">Customer Care</div>
      <a class="footer-link" href="#">FAQ</a>
      <a class="footer-link" href="https://wa.me/60123456789" target="_blank" rel="noopener">WhatsApp Us</a>
    </div>

    <div class="footer-col">
      <div class="footer-title">Connect</div>

      <a class="footer-link footer-social"
         href="https://instagram.com/girliescafe"
         target="_blank" rel="noopener">
        <i class="fab fa-instagram"></i> Instagram
      </a>

      <a class="footer-link footer-social"
         href="https://facebook.com/girliescafe"
         target="_blank" rel="noopener">
        <i class="fab fa-facebook-f"></i> Facebook
      </a>

      <a class="footer-link footer-contact" href="tel:+60111111111">
        <i class="fas fa-phone-alt"></i> +60-11-1111111
      </a>
    </div>

  </div>

  <div class="footer-bottom">
    © 2025 Girlie’s Café. All Rights Reserved.
  </div>
</footer>

<script>
document.addEventListener("DOMContentLoaded", () => {
  // Cafe Highlights
  new Swiper(".favSwiper", {
    loop: true,
    slidesPerView: 1,
    spaceBetween: 0,
    navigation: {
      nextEl: ".fav-swiper-next",
      prevEl: ".fav-swiper-prev",
    },
    pagination: {
      el: ".fav-swiper-pagination",
      clickable: true,
    },
    autoplay: { delay: 3000, disableOnInteraction: false },
  });

  // Team
  new Swiper(".teamSwiper", {
    loop: true,
    slidesPerView: 1,
    spaceBetween: 0,
    navigation: {
      nextEl: ".team-swiper-next",
      prevEl: ".team-swiper-prev",
    },
    pagination: {
      el: ".team-swiper-pagination",
      clickable: true,
    },
    autoplay: { delay: 3000, disableOnInteraction: false },
  });
});
</script>


<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
</body>
</html>