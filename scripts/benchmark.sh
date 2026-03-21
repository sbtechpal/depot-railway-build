#!/bin/bash

# Depot CI Benchmark Script
# Runs both workflows and captures timing data

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Configuration
PROJECT_NAME="openclaw-demo"
ITERATIONS=3
RESULTS_DIR="./benchmarks/results"

mkdir -p "$RESULTS_DIR"

print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_step() {
    echo -e "${GREEN}✓${NC} $1"
}

# Start benchmark
print_header "Depot CI Benchmark Runner"

echo "Running $ITERATIONS iterations of each workflow..."
echo "Results will be saved to: $RESULTS_DIR"
echo ""

# Baseline: Local build simulation
print_header "Test 1: Local Build (Baseline Simulation)"

for i in $(seq 1 $ITERATIONS); do
    echo "Iteration $i/$ITERATIONS"

    START=$(date +%s)

    # Clean build
    cd sample-app
    rm -rf node_modules dist
    npm install --silent
    npm run build --silent
    cd ..

    END=$(date +%s)
    DURATION=$((END - START))

    echo "Duration: ${DURATION}s"
    echo "$i,$DURATION" >> "$RESULTS_DIR/baseline.csv"

    sleep 2
done

print_step "Baseline tests complete"

# Docker build
print_header "Test 2: Docker Build"

for i in $(seq 1 $ITERATIONS); do
    echo "Iteration $i/$ITERATIONS"

    START=$(date +%s)

    docker build -t $PROJECT_NAME:bench ./sample-app > /dev/null 2>&1

    END=$(date +%s)
    DURATION=$((END - START))

    echo "Duration: ${DURATION}s"
    echo "$i,$DURATION" >> "$RESULTS_DIR/docker.csv"

    sleep 2
done

print_step "Docker build tests complete"

# Generate summary
print_header "Benchmark Results Summary"

echo "Baseline (local build):"
awk -F, '{sum+=$2; count++} END {print "  Average: " sum/count " seconds"}' "$RESULTS_DIR/baseline.csv"

echo "Docker build:"
awk -F, '{sum+=$2; count++} END {print "  Average: " sum/count " seconds"}' "$RESULTS_DIR/docker.csv"

echo ""
echo -e "${YELLOW}Note:${NC} These are local benchmarks. Depot CI performance will be better"
echo "due to distributed caching and optimized infrastructure."
echo ""
echo "Full results saved to: $RESULTS_DIR"
