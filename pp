document.addEventListener("keydown", function(event) {
    let keyName;
    switch (event.key) {
        case "ArrowUp":
            keyName = "Стрелка вверх";
            break;
        case "ArrowDown":
            keyName = "Стрелка вниз";
            break;
        case "ArrowLeft":
            keyName = "Стрелка влево";
            break;
        case "ArrowRight":
            keyName = "Стрелка вправо";
            break;
        case "Enter":
            keyName = "Enter";
            break;
        case "Escape":
            keyName = "Esc";
            break;
        case "Alt":
            keyName = "Alt";
            break;
        case "Control":
            keyName = "Control";
            break;
        case "Shift":
            keyName = "Shift";
            break;
        
        default:
            keyName = event.key;
    }
    console.log(`Код клавиши: ${event.keyCode}, Клавиша: ${keyName}`);
});


const arrowButtons = {
    ArrowUp: document.getElementById("up"),
    ArrowDown: document.getElementById("down"),
    ArrowLeft: document.getElementById("left"),
    ArrowRight: document.getElementById("right")
};

document.addEventListener("keydown", function(event) {
    if (arrowButtons[event.key]) {
        arrowButtons[event.key].classList.add("active");
    }
});

document.addEventListener("keyup", function(event) {
    if (arrowButtons[event.key]) {
        arrowButtons[event.key].classList.remove("active");
    }
});


const objectCanvas = document.getElementById("objectCanvas");
const objectCtx = objectCanvas.getContext("2d");
let objectX = 180;
let objectY = 80;
const objectSize = 40;

function drawObject() {
    objectCtx.clearRect(0, 0, objectCanvas.width, objectCanvas.height);
    objectCtx.fillStyle = "blue";
    objectCtx.fillRect(objectX, objectY, objectSize, objectSize);
}

document.addEventListener("keydown", function(event) {
    const step = 10;
    switch (event.key) {
        case "ArrowUp":
            objectY = Math.max(0, objectY - step);
            break;
        case "ArrowDown":
            objectY = Math.min(objectCanvas.height - objectSize, objectY + step);
            break;
        case "ArrowLeft":
            objectX = Math.max(0, objectX - step);
            break;
        case "ArrowRight":
            objectX = Math.min(objectCanvas.width - objectSize, objectX + step);
            break;
    }
    drawObject();
});

drawObject();


const gameCanvas = document.getElementById("gameCanvas");
const gameCtx = gameCanvas.getContext("2d");
const ballRadius = 10;
let ballX = 50;
let ballY = 200;
let ballSpeedX = 4;
let ballSpeedY = 4;
const paddleWidth = 10;
const paddleHeight = 80;
let paddleY = 160;

function drawBall() {
    gameCtx.beginPath();
    gameCtx.arc(ballX, ballY, ballRadius, 0, Math.PI * 2);
    gameCtx.fillStyle = "red";
    gameCtx.fill();
    gameCtx.closePath();
}

function drawPaddle() {
    gameCtx.fillStyle = "green";
    gameCtx.fillRect(gameCanvas.width - paddleWidth, paddleY, paddleWidth, paddleHeight);
}

function drawGame() {
    gameCtx.clearRect(0, 0, gameCanvas.width, gameCanvas.height);
    drawBall();
    drawPaddle();

  
    ballX += ballSpeedX;
    ballY += ballSpeedY;


    if (ballY + ballRadius > gameCanvas.height || ballY - ballRadius < 0) {
        ballSpeedY *= -1;
    }


    if (ballX + ballRadius > gameCanvas.width) {
        alert("Вы проиграли!");
        resetGame();
    }


    if (
        ballX + ballRadius > gameCanvas.width - paddleWidth &&
        ballY > paddleY &&
        ballY < paddleY + paddleHeight
    ) {
        ballSpeedX *= -1;
    }

    requestAnimationFrame(drawGame);
}

function resetGame() {
    ballX = 50;
    ballY = 200;
    ballSpeedX = 4;
    ballSpeedY = 4;
    paddleY = 160;
}

document.addEventListener("keydown", function(event) {
    const paddleStep = 20;
    if (event.key === "ArrowUp") {
        paddleY = Math.max(0, paddleY - paddleStep);
    } else if (event.key === "ArrowDown") {
        paddleY = Math.min(gameCanvas.height - paddleHeight, paddleY + paddleStep);
    }
});

drawGame();
