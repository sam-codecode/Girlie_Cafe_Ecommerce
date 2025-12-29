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
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assests/css/home.css">

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
      <a class="navi-link" href="<%= request.getContextPath() %>/user/products.jsp">Menu</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/cart.jsp">Cart</a>
      <a class="navi-link" href="<%= request.getContextPath() %>/user/orders.jsp">My History</a>
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

      <a class="explore-btn pop-effect" href="<%= request.getContextPath() %>/user/products.jsp">
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
            <div class="stat-big">20+</div>
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

      <div class="fav-slider" id="favSlider">

        <!-- Track -->
        <div class="fav-viewport">
          <div class="fav-track" id="favTrack">

            <article class="fav-card">
              <img class="fav-img"
                   src="<%= request.getContextPath() %>/assets/images/topfav/parmigiana.png"
                   alt="Chicken Parmigiana">
              <div class="fav-body">
                <h3>Chicken Parmigiana</h3>
                <p>Crispy chicken with marinara, melted cheese &amp; fresh salad.</p>
                <div class="fav-price">Price: RM 23.00</div>
                <a class="view-btn" href="<%= request.getContextPath() %>/user/products.jsp">View Details</a>
              </div>
            </article>

            <article class="fav-card">
              <img class="fav-img"
                   src="<%= request.getContextPath() %>/assets/images/topfav/truffle.png"
                   alt="Truffle Carbonara">
              <div class="fav-body">
                <h3>Truffle Carbonara</h3>
                <p>Creamy carbonara with parmesan, truffle aroma &amp; crispy bacon.</p>
                <div class="fav-price">Price: RM 25.00</div>
                <a class="view-btn" href="<%= request.getContextPath() %>/user/products.jsp">View Details</a>
              </div>
            </article>

            <article class="fav-card">
              <img class="fav-img"
                   src="<%= request.getContextPath() %>/assets/images/topfav/tonkatsu.png"
                   alt="Tonkatsu Rice">
              <div class="fav-body">
                <h3>Tonkatsu Rice</h3>
                <p>Crispy chicken cutlet with Japanese sauce, rice &amp; fresh salad.</p>
                <div class="fav-price">Price: RM 19.00</div>
                <a class="view-btn" href="<%= request.getContextPath() %>/user/products.jsp">View Details</a>
              </div>
            </article>

            <article class="fav-card">
              <img class="fav-img"
                   src="<%= request.getContextPath() %>/assets/images/topfav/lava-cake.png"
                   alt="Chocolate Lava Cake">
              <div class="fav-body">
                <h3>Chocolate Lava Cake</h3>
                <p>Warm chocolate cake with molten centre.</p>
                <div class="fav-price">Price: RM 10.00</div>
                <a class="view-btn" href="<%= request.getContextPath() %>/user/products.jsp">View Details</a>
              </div>
            </article>

            <article class="fav-card">
              <img class="fav-img"
                   src="<%= request.getContextPath() %>/assets/images/topfav/latte.png"
                   alt="Iced Lotus Latte">
              <div class="fav-body">
                <h3>Iced Lotus Latte</h3>
                <p>Chilled latte blended with sweet Lotus Biscoff flavour.</p>
                <div class="fav-price">Price: RM 12.00</div>
                <a class="view-btn" href="<%= request.getContextPath() %>/user/products.jsp">View Details</a>
              </div>
            </article>

          </div>
        </div>

        <!-- Arrows -->
        <button class="fav-arrow left" id="favPrev" type="button" aria-label="Previous">‹</button>
        <button class="fav-arrow right" id="favNext" type="button" aria-label="Next">›</button>

      </div>

      <!-- Dots -->
      <div class="fav-dots" id="favDots" aria-label="Slider pagination"></div>

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
        <a class="service-link" href="<%= request.getContextPath() %>/user/products.jsp">
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
        <a class="service-link" href="<%= request.getContextPath() %>/user/products.jsp">
          Order Now →
        </a>
      </div>

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

<!-- =========================
     SLIDER JS (ADDED TO JSP ✅)
========================== -->
<script>
  const track = document.getElementById("favTrack");
  const slides = Array.from(track.querySelectorAll(".fav-card"));
  const prevBtn = document.getElementById("favPrev");
  const nextBtn = document.getElementById("favNext");
  const dotsWrap = document.getElementById("favDots");
  const slider = document.getElementById("favSlider");

  let index = 0;
  let timer = null;
  const intervalMs = 5000;

  const dots = slides.map((_, i) => {
    const b = document.createElement("button");
    b.className = "fav-dot";
    b.type = "button";
    b.setAttribute("aria-label", `Go to slide ${i + 1}`);
    b.addEventListener("click", () => goTo(i, true));
    dotsWrap.appendChild(b);
    return b;
  });

  function updateDots() {
    dots.forEach((d, i) => d.classList.toggle("active", i === index));
  }

  function goTo(i, userAction = false) {
    index = (i + slides.length) % slides.length;
    track.style.transform = `translateX(-${index * 100}%)`;
    updateDots();
    if (userAction) restartAuto();
  }

  function next() { goTo(index + 1, true); }
  function prev() { goTo(index - 1, true); }

  prevBtn.addEventListener("click", prev);
  nextBtn.addEventListener("click", next);

  function startAuto() {
    stopAuto();
    timer = setInterval(() => goTo(index + 1), intervalMs);
  }

  function stopAuto() {
    if (timer) clearInterval(timer);
    timer = null;
  }

  function restartAuto() {
    stopAuto();
    startAuto();
  }

  slider.addEventListener("mouseenter", stopAuto);
  slider.addEventListener("mouseleave", startAuto);

  goTo(0);
  startAuto();
</script>

</body>
</html>