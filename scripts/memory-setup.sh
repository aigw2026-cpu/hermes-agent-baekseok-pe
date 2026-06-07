#!/bin/bash
# Hermes Agent 메모리 등록 스크립트
# 백석대 특수체육 학회지 규칙 영구 등록
# 사용법: bash memory-setup.sh

echo "========================================"
echo " Hermes 메모리 등록 시작"
echo "========================================"

# 학회지 규칙 메모리 등록
hermes memory add "학회지_규칙" "한국특수체육학회지 투고 규칙: p<.05 유의수준, Hedges g 효과크기, PRISMA 체크리스트 준수, SEM 사용 필수"

hermes memory add "통계_기준" "메타분석 효과크기: small=0.2, medium=0.5, large=0.8 (Cohen's d 기준). 이분산 모형 사용 권장."

hermes memory add "검색_전략" "PubMed 검색: (intellectual disability OR special needs) AND (physical activity OR exercise) AND (meta-analysis OR systematic review)"

hermes memory add "병렬_설정" "workers=4로 설정 완료. 논문 4편 동시 처리 가능. API port=8765"

hermes memory add "n8n_연동" "n8n URL: https://aigw2026.app.n8n.cloud. Hermes API: http://localhost:8765. 워크플로우: harness-v4-hermes.json"

hermes memory add "스케줄" "매일 오전 10시 자동 실행. Google Calendar 등록 완료 (aigw2026@gmail.com). n8n Cron: 0 10 * * *"

echo ""
echo "등록된 메모리 목록:"
hermes memory list

echo ""
echo "========================================"
echo " 메모리 등록 완료!"
echo "========================================"
