
const cards = [
  {
    q: "What are reserves in Uniswap V2?",
    a: "The actual quantities of token0 and token1 held by the pool."
  },
  {
    q: "What does the V2 invariant represent?",
    a: "The constant-product relationship: k = x × y."
  },
  {
    q: "How do you calculate token0's price in token1 units?",
    a: "Price = reserve(token1) / reserve(token0)."
  },
  {
    q: "What generally reduces price impact for the same trade?",
    a: "Greater active liquidity relative to the trade size."
  },
  {
    q: "What is capital efficiency in Uniswap V3?",
    a: "Concentrating capital in selected price ranges instead of across the full curve."
  },
  {
    q: "What boundaries can a V3 liquidity provider choose?",
    a: "A lower price boundary and an upper price boundary."
  },
  {
    q: "When does an LP position become inactive?",
    a: "When the price moves outside its selected range; it stops earning swap fees there."
  },
  {
    q: "What are ticks in Uniswap V3?",
    a: "Predefined price boundaries where liquidity positions can begin or end."
  },
  {
    q: "What happens when a swap crosses a tick?",
    a: "The pool updates active liquidity and continues the swap if liquidity is available."
  },
  {
    q: "Is piecewise x × y = kᵢ the literal V3 implementation?",
    a: "No. It is a teaching model. V3 uses L, sqrtPriceX96 and tick boundaries."
  },
  {
    q: "If both V2 reserves double proportionally, what happens to spot price?",
    a: "It stays the same because the reserve ratio is unchanged."
  },
  {
    q: "What happens to token0's price when its reserve decreases?",
    a: "Its price in token1 generally increases if the other reserve stays constant."
  },
  {
    q: "What is price impact in an AMM?",
    a: "The price change caused by a trade."
  },
  {
    q: "Why does a larger pool usually have lower price impact?",
    a: "The same trade is smaller relative to available liquidity, so it moves the price less."
  },
  {
    q: "Why can V3 liquidity be more capital-efficient than V2 liquidity?",
    a: "V3 lets LPs concentrate liquidity in a selected price range."
  },
  {
    q: "What happens when price moves outside an LP's range?",
    a: "The position becomes inactive and stops earning swap fees until price returns."
  },
  {
    q: "What determines valid tick-boundary spacing?",
    a: "The pool's configured tick spacing, which is associated with its fee tier."
  },
  {
    q: "Does crossing a tick itself deposit or withdraw tokens?",
    a: "No. Crossing updates active liquidity; it does not itself deposit or withdraw tokens."
  },
  {
    q: "What should an auditor check during tick crossing?",
    a: "Correct active-liquidity updates and safe swap handling at liquidity boundaries."
  },
  {
    q: "What does sqrtPriceX96 represent in V3?",
    a: "The square-root price encoded in Q64.96 fixed-point format."
  }
];

let current = 0;
let revealed = false;
const reviewed = new Map();

const flashcard = document.getElementById("flashcard");
const cardLabel = document.getElementById("cardLabel");
const cardNumber = document.getElementById("cardNumber");
const cardContent = document.getElementById("cardContent");
const cardHint = document.getElementById("cardHint");
const counter = document.getElementById("counter");
const knownCount = document.getElementById("knownCount");
const progressBar = document.getElementById("progressBar");
const revealBtn = document.getElementById("revealBtn");
const rating = document.getElementById("rating");

function render() {
  const card = cards[current];

  cardLabel.textContent = revealed ? "ANSWER" : "QUESTION";
  cardNumber.textContent = String(current + 1).padStart(2, "0");
  cardContent.textContent = revealed ? card.a : card.q;
  cardHint.textContent = revealed
    ? "Click to hide answer"
    : "Click to reveal answer ↗";

  counter.textContent = `Card ${current + 1} of ${cards.length}`;
  knownCount.textContent =
    `Known: ${[...reviewed.values()].filter(v => v === "known").length}`;

  progressBar.style.width =
    `${((current + 1) / cards.length) * 100}%`;

  revealBtn.textContent = revealed ? "Hide Answer" : "Reveal Answer";
  rating.classList.toggle("hidden", !revealed);
}

function toggleAnswer() {
  revealed = !revealed;
  render();
}

function goTo(index) {
  current = (index + cards.length) % cards.length;
  revealed = false;
  render();
}

flashcard.addEventListener("click", toggleAnswer);
revealBtn.addEventListener("click", toggleAnswer);

document.getElementById("prevBtn").addEventListener("click", () => {
  goTo(current - 1);
});

document.getElementById("nextBtn").addEventListener("click", () => {
  goTo(current + 1);
});

document.getElementById("knownBtn").addEventListener("click", () => {
  reviewed.set(current, "known");
  goTo(current + 1);
});

document.getElementById("missedBtn").addEventListener("click", () => {
  reviewed.set(current, "missed");
  goTo(current + 1);
});

document.addEventListener("keydown", event => {
  if (event.code === "Space") {
    event.preventDefault();
    toggleAnswer();
  } else if (event.key === "ArrowRight") {
    goTo(current + 1);
  } else if (event.key === "ArrowLeft") {
    goTo(current - 1);
  }
});

render();
