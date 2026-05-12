<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>에겐 vs 테토 정밀 성향 테스트</title>
    <style>
        body { font-family: 'Pretendard', -apple-system, sans-serif; background-color: #f0f2f5; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        #test-container { background: white; padding: 40px; border-radius: 24px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); width: 95%; max-width: 550px; text-align: center; }
        .progress-bar { width: 100%; height: 8px; background: #eee; border-radius: 10px; margin-bottom: 20px; overflow: hidden; }
        #progress-inner { width: 0%; height: 100%; background: linear-gradient(90deg, #ec4899, #2563eb); transition: 0.3s; }
        .question { font-size: 1.3rem; margin-bottom: 35px; line-height: 1.5; font-weight: 700; color: #1a1a1a; min-height: 80px; display: flex; align-items: center; justify-content: center; }
        .options { display: flex; flex-direction: column; gap: 12px; }
        button { padding: 16px; border: 1px solid #e5e7eb; border-radius: 15px; cursor: pointer; font-size: 1rem; transition: 0.2s; background: white; color: #4b5563; font-weight: 500; }
        button:hover { background: #f9fafb; border-color: #3730a3; color: #3730a3; transform: translateY(-2px); }
        #result { display: none; }
        .result-title { font-size: 2rem; font-weight: 800; margin-bottom: 20px; }
        .result-desc { line-height: 1.8; color: #4b5563; font-size: 1.1rem; background: #f8fafc; padding: 20px; border-radius: 15px; margin-bottom: 25px; }
        .reset-btn { background: #1f2937; color: white; border: none; width: 100%; }
        .reset-btn:hover { background: #000; color: white; }
    </style>
</head>
<body>

<div id="test-container">
    <div id="quiz">
        <div class="progress-bar"><div id="progress-inner"></div></div>
        <div id="q-number" style="font-size: 0.9rem; color: #9ca3af; margin-bottom: 10px;">질문 1 / 7</div>
        <div class="question" id="q-text">질문이 여기에 표시됩니다.</div>
        <div class="options">
            <button onclick="next(5)">매우 그렇다</button>
            <button onclick="next(4)">그런 편이다</button>
            <button onclick="next(3)">보통이다</button>
            <button onclick="next(2)">아닌 편이다</button>
            <button onclick="next(1)">전혀 아니다</button>
        </div>
    </div>

    <div id="result">
        <div id="res-label" style="font-weight: 600; color: #6b7280; margin-bottom: 5px;">당신의 성향은?</div>
        <div class="result-title" id="res-type">타입 결과</div>
        <div class="result-desc" id="res-desc">설명</div>
        <button class="reset-btn" onclick="location.reload()">다시 테스트하기</button>
    </div>
</div>

<script>
    const questions = [
        "영화나 드라마를 볼 때 등장인물의 슬픔에 깊이 공감하여 감정이입을 자주 한다.",
        "중요한 결정을 내릴 때 논리적인 이익보다는 주변 사람들의 기분과 화합을 더 고려한다.",
        "누군가와 갈등이 생기면 내 주장을 관철하기보다 먼저 사과하거나 관계를 회복하려 노력한다.",
        "친구가 힘든 일을 털어놓으면 해결책을 제시하기보다 충분히 들어주고 위로해주는 것이 먼저다.",
        "주변 사람들에게 '부드럽다', '섬세하다', '다정하다'라는 말을 자주 듣는 편이다.",
        "경쟁적인 분위기보다는 서로 돕고 의지하는 협력적인 분위기에서 능률이 더 오른다.",
        "나의 감정 상태를 솔직하게 표현하고 타인과 감정적으로 교류하는 것에 거부감이 없다."
    ];

    let currentIdx = 0;
    let totalScore = 0;

    function updateProgress() {
        const percent = ((currentIdx) / questions.length) * 100;
        document.getElementById('progress-inner').style.width = percent + "%";
        document.getElementById('q-number').innerText = `질문 ${currentIdx + 1} / ${questions.length}`;
    }

    function showQuestion() {
        if (currentIdx < questions.length) {
            document.getElementById('q-text').innerText = questions[currentIdx];
            updateProgress();
        } else {
            showResult();
        }
    }

    function next(score) {
        totalScore += score;
        currentIdx++;
        showQuestion();
    }

    function showResult() {
        document.getElementById('quiz').style.display = 'none';
        const resDiv = document.getElementById('result');
        const resType = document.getElementById('res-type');
        const resDesc = document.getElementById('res-desc');
        resDiv.style.display = 'block';

        // 총점 기준: 7문항 x 3점(보통이다) = 21점
        // 21점 초과는 에겐 성향, 미만은 테토 성향
        if (totalScore > 21) {
            resType.innerText = "에겐 (Estrogen) 타입";
            resType.style.color = "#ec4899";
            resDesc.innerHTML = "<b>따뜻한 감성과 공감의 소유자</b><br><br>당신은 에스트로겐의 특징인 섬세함과 높은 공감 능력을 가지고 있습니다. 주변 사람들의 마음을 잘 읽고 배려하며, 평화로운 관계를 유지하는 데 탁월한 재능이 있습니다. 다정다감한 에너지가 매력적인 분이시네요!";
        } else if (totalScore < 21) {
            resType.innerText = "테토 (Testosterone) 타입";
            resType.style.color = "#2563eb";
            resDesc.innerHTML = "<b>강력한 추진력과 논리의 소유자</b><br><br>당신은 테스토스테론의 특징인 결단력과 독립적인 성향이 강합니다. 감정에 휘둘리기보다 목표를 향해 효율적으로 움직이며, 논리적으로 상황을 판단하는 능력이 뛰어납니다. 당당하고 시원시원한 리더십이 돋보이는 분이시네요!";
        } else {
            resType.innerText = "에겐-테토 밸런스 타입";
            resType.style.color = "#8b5cf6";
            resDesc.innerHTML = "<b>상황에 따라 유연한 중립적 소유자</b><br><br>당신은 부드러운 감성과 강한 추진력을 고루 갖추고 있습니다. 때로는 공감해주고, 필요할 때는 단호하게 결단을 내릴 줄 아는 유연한 기질을 가지셨군요! 상황에 맞춰 본인의 에너지를 조절할 줄 아는 멋진 균형 감각을 보유하고 있습니다.";
        }
    }

    showQuestion();
</script>

</body>
</html>
