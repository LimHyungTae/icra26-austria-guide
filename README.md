<div align="center">

<h1>빈(Vienna) 한 손에 잡기</h1>

<p><strong><em>ICRA 2026 참석자를 위한 오스트리아 · 빈 여행 가이드</em></strong></p>

<p><a href="https://limhyungtae.github.io/icra26-austria-guide/">Website</a></p>

</div>

빈의 주요 궁전·성당·기념비에 "태그"를 붙여, 그 의미와 역사·사회적 배경을 한국인 시각으로 재미있게 풀어쓴 가이드입니다. 학회 틈틈이 도시를 거닐 때 알아두면 두 배로 보이는 이야기들을 모았습니다.

## 다루는 곳

- **인트로** — 합스부르크 개혁군주(마리아 테레지아·요제프 2세), 오스트리아 4대 장군, 두 수호성인, 빈 1900과 프로이트, 공중보건(감자·천연두·제멜바이스) 이야기
- **벨베데레 궁전** — 오이겐 공의 별궁, 클림트 「키스」, 분리파와 "욕망"의 미술
- **쇤부른 궁전** — 마리아 테레지아의 여름 궁전, 어린 모차르트, 글로리에테
- **성 슈테판 성당** — 컬러 지붕(쌍두독수리), 슈테플, 푸머린, 거인의 문, "성당 든 사람"의 정체
- **성 페터 성당** — 그라벤 옆 바로크 돔, 로트마이어 천장화
- **성 카를 성당** — 페스트 서원, 트라야누스 기둥, 헨리 무어의 조각
- **호흐슈트랄 분수 & 소련군 기념비** — 슈바르첸베르크 광장의 분수와 그 뒤의 병사상
- **호프부르크 & 헬덴광장** — 겨울 궁전, 말 위의 두 영웅(오이겐·카를)

## 배포

정적 사이트는 `docs/index.html`에서 제공되며, `main` 브랜치에 push되면 `.github/workflows/pages.yml` workflow가 `docs/` 폴더를 GitHub Pages로 배포합니다. GitHub Pages가 아직 활성화되어 있지 않다면 repository Settings → Pages에서 Source를 **GitHub Actions**로 한 번 설정해야 합니다.

## 이미지

사진은 [위키미디어 커먼즈](https://commons.wikimedia.org/)의 자유 라이선스(공용·CC) 이미지를 `scripts/fetch_images.sh`로 내려받아 `docs/assets/`에 보관합니다. 스크립트를 다시 실행하면 이미 받은 파일은 건너뜁니다.

```bash
bash scripts/fetch_images.sh
```

## 로컬 미리보기

```bash
cd docs && python3 -m http.server 8000
# http://localhost:8000 접속
```
