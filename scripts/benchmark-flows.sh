#!/bin/bash

# Depot CI Benchmark Script (Docker-Free Version)
# Measures timing for flows 1, 2, and 3 without Docker dependency
# Run this to establish baseline metrics before implementing Depot CI

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
PROJECT_NAME="openclaw-demo"
ITERATIONS=3
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Get absolute paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
RESULTS_DIR="$PROJECT_ROOT/benchmarks/results"
RESULTS_FILE="$RESULTS_DIR/benchmark_${TIMESTAMP}.csv"

# Check if Docker is available
DOCKER_AVAILABLE=false
if command -v docker &> /dev/null; then
    if docker ps &> /dev/null 2>&1; then
        DOCKER_AVAILABLE=true
    fi
fi

print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_step() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_skip() {
    echo -e "${YELLOW}⊗${NC} $1 (skipped)"
}

# Main benchmark execution
main() {
    print_header "Depot CI Benchmark - Flows 1, 2, 3 (Docker-Free)"

    echo "Benchmark configuration:"
    echo "  Project: $PROJECT_NAME"
    echo "  Iterations: $ITERATIONS"
    echo "  Results: $RESULTS_FILE"
    echo "  Docker: $([ "$DOCKER_AVAILABLE" == "true" ] && echo "Available" || echo "Not Available")"
    echo ""

    # Create results directory
    mkdir -p "$RESULTS_DIR"

    # CSV header
    echo "flow,iteration,stage,duration,timestamp" > "$RESULTS_FILE"

    # ========================================
    # FLOW 1: Local Build (without Docker)
    # ========================================
    print_header "Flow 1: Local Build (Docker-Free)"
    print_info "Building locally (Docker build skipped - not available)"

    for i in $(seq 1 $ITERATIONS); do
        echo ""
        echo "Iteration $i/$ITERATIONS"

        cd "$PROJECT_ROOT/sample-app"

        # Stage 1: Install dependencies
        print_info "Stage 1: Installing dependencies..."
        START=$(date +%s)
        npm install --silent --no-audit --no-fund > /dev/null 2>&1
        END=$(date +%s)
        DEPS_DURATION=$((END - START))
        echo "  Dependencies: ${DEPS_DURATION}s"
        echo "flow1,$i,dependencies,$DEPS_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 2: TypeScript build
        print_info "Stage 2: Building TypeScript..."
        START=$(date +%s)
        npm run build --silent > /dev/null 2>&1
        END=$(date +%s)
        BUILD_DURATION=$((END - START))
        echo "  TypeScript: ${BUILD_DURATION}s"
        echo "flow1,$i,typescript,$BUILD_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 3: Docker build (if available)
        if [ "$DOCKER_AVAILABLE" = true ]; then
            print_info "Stage 3: Building Docker image..."
            START=$(date +%s)
            docker build -t $PROJECT_NAME:bench . > /dev/null 2>&1
            END=$(date +%s)
            DOCKER_DURATION=$((END - START))
            echo "  Docker build: ${DOCKER_DURATION}s"
            echo "flow1,$i,docker,$DOCKER_DURATION,$(date +%s)" >> "$RESULTS_FILE"
        else
            print_skip "Stage 3: Docker build (not available)"
            echo "flow1,$i,docker,SKIPPED,$(date +%s)" >> "$RESULTS_FILE"
        fi

        # Calculate total (without docker if skipped)
        if [ "$DOCKER_AVAILABLE" = true ]; then
            TOTAL_DURATION=$((DEPS_DURATION + BUILD_DURATION + DOCKER_DURATION))
        else
            TOTAL_DURATION=$((DEPS_DURATION + BUILD_DURATION))
        fi
        echo "  ${GREEN}Flow 1 Total: ${TOTAL_DURATION}s${NC}"
        echo "flow1,$i,total,$TOTAL_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        cd "$PROJECT_ROOT"
        sleep 1
    done

    # ========================================
    # FLOW 2: Railway Auto-Build (informational)
    # ========================================
    print_header "Flow 2: Git Push → Railway Auto-Build"
    print_info "Note: This requires Railway autobuild to be enabled"
    print_info "This flow is documented only (run manually to save credits)"

    echo ""
    echo "Flow 2 process:"
    echo "  1. Push code to GitHub"
    echo "  2. Railway detects change and builds"
    echo "  3. Record time from Railway dashboard"
    echo ""
    echo "Expected timing: 180-300 seconds (3-5 minutes)"
    echo "Cost: ~$0.05 per build"
    echo ""
    echo "flow2,documentation,expected_time,240,$(date +%s)" >> "$RESULTS_FILE"
    echo "flow2,documentation,cost_per_build,0.05,$(date +%s)" >> "$RESULTS_FILE"

    # ========================================
    # FLOW 3: GitHub Actions (Simulated)
    # ========================================
    print_header "Flow 3: GitHub Actions → Railway (Simulated)"
    print_info "Simulating GitHub Actions workflow locally"

    for i in $(seq 1 $ITERATIONS); do
        echo ""
        echo "Iteration $i/$ITERATIONS"

        cd "$PROJECT_ROOT/sample-app"

        # Clean for fair comparison
        rm -rf node_modules dist

        # Stage 1: Checkout (simulated)
        print_info "Stage 1: Checkout (simulated)"
        START=$(date +%s)
        sleep 1
        END=$(date +%s)
        CHECKOUT_DURATION=$((END - START))
        echo "  Checkout: ${CHECKOUT_DURATION}s"
        echo "flow3,$i,checkout,$CHECKOUT_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 2: Setup Node (simulated)
        print_info "Stage 2: Setup Node (simulated)"
        START=$(date +%s)
        sleep 1
        END=$(date +%s)
        SETUP_DURATION=$((END - START))
        echo "  Setup: ${SETUP_DURATION}s"
        echo "flow3,$i,setup,$SETUP_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 3: Install dependencies
        print_info "Stage 3: Installing dependencies..."
        START=$(date +%s)
        npm ci --silent --no-audit --no-fund > /dev/null 2>&1
        END=$(date +%s)
        DEPS_DURATION=$((END - START))
        echo "  Dependencies: ${DEPS_DURATION}s"
        echo "flow3,$i,dependencies,$DEPS_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 4: Run tests
        print_info "Stage 4: Running tests..."
        START=$(date +%s)
        npm test --silent > /dev/null 2>&1 || true
        END=$(date +%s)
        TEST_DURATION=$((END - START))
        echo "  Tests: ${TEST_DURATION}s"
        echo "flow3,$i,tests,$TEST_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 5: Build
        print_info "Stage 5: Building application..."
        START=$(date +%s)
        npm run build --silent
        END=$(date +%s)
        BUILD_DURATION=$((END - START))
        echo "  Build: ${BUILD_DURATION}s"
        echo "flow3,$i,build,$BUILD_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 6: Deploy (simulated)
        if command -v railway &> /dev/null; then
            print_info "Stage 6: Deploy to Railway (simulated)"
            START=$(date +%s)
            sleep 2
            END=$(date +%s)
            DEPLOY_DURATION=$((END - START))
            echo "  Deploy: ${DEPLOY_DURATION}s (simulated)"
            echo "flow3,$i,deploy,$DEPLOY_DURATION,$(date +%s)" >> "$RESULTS_FILE"
        else
            print_skip "Stage 6: Deploy (Railway CLI not configured)"
            echo "flow3,$i,deploy,SKIPPED,$(date +%s)" >> "$RESULTS_FILE"
        fi

        # Calculate total
        TOTAL_DURATION=$((CHECKOUT_DURATION + SETUP_DURATION + DEPS_DURATION + TEST_DURATION + BUILD_DURATION))
        echo "  ${GREEN}Flow 3 Total: ${TOTAL_DURATION}s${NC}"
        echo "flow3,$i,total,$TOTAL_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        cd "$PROJECT_ROOT"
        sleep 1
    done

    # ========================================
    # FLOW 4: Depot CI (Placeholder)
    # ========================================
    print_header "Flow 4: Depot CI → Railway"
    print_warning "Depot CI not yet configured"
    print_info "Expected timing based on Depot claims:"
    print_info "  Dependencies: ~5s (9x faster)"
    print_info "  TypeScript: ~3s (10x faster)"
    print_info "  Docker: ~8s (11x faster)"
    print_info "  Deploy: ~10s"
    print_info "  ${GREEN}Total: ~30s (5-10x faster)${NC}"

    # Add placeholder to CSV
    echo "flow4,placeholder,dependencies,5,DEPOT_CI_PENDING" >> "$RESULTS_FILE"
    echo "flow4,placeholder,typescript,3,DEPOT_CI_PENDING" >> "$RESULTS_FILE"
    echo "flow4,placeholder,docker,8,DEPOT_CI_PENDING" >> "$RESULTS_FILE"
    echo "flow4,placeholder,deploy,10,DEPOT_CI_PENDING" >> "$RESULTS_FILE"
    echo "flow4,placeholder,total,26,DEPOT_CI_PENDING" >> "$RESULTS_FILE"

    # ========================================
    # RESULTS SUMMARY
    # ========================================
    print_header "Benchmark Results Summary"
    echo ""
    echo "Results saved to: $RESULTS_FILE"
    echo ""

    # Calculate Flow 1 averages
    echo "Flow 1 (Local Build) Averages:"
    DEPS_AVG=$(awk -F, '$1=="flow1" && $3=="dependencies" {sum+=$4; count++} END {if(count>0) print "  Dependencies: " sum/count " seconds"}' "$RESULTS_FILE")
    BUILD_AVG=$(awk -F, '$1=="flow1" && $3=="typescript" {sum+=$4; count++} END {if(count>0) print "  TypeScript: " sum/count " seconds"}' "$RESULTS_FILE")
    TOTAL_AVG=$(awk -F, '$1=="flow1" && $3=="total" {sum+=$4; count++} END {if(count>0) print "  Total: " sum/count " seconds"}' "$RESULTS_FILE")
    echo ""
    echo "  Note: Docker build was $([ "$DOCKER_AVAILABLE" == "true" ] && echo "included" || echo "skipped (not available)")"

    echo ""
    echo "Flow 2 (Railway Auto-Build) Notes:"
    echo "  Expected time: 180-300 seconds"
    echo "  Cost: ~$0.05 per build"
    echo "  Run manually to save credits"

    echo ""
    echo "Flow 3 (GitHub Actions) Averages:"
    DEPS_AVG=$(awk -F, '$1=="flow3" && $3=="dependencies" {sum+=$4; count++} END {if(count>0) print "  Dependencies: " sum/count " seconds"}' "$RESULTS_FILE")
    BUILD_AVG=$(awk -F, '$1=="flow3" && $3=="build" {sum+=$4; count++} END {if(count>0) print "  Build: " sum/count " seconds"}' "$RESULTS_FILE")
    TOTAL_AVG=$(awk -F, '$1=="flow3" && $3=="total" {sum+=$4; count++} END {if(count>0) print "  Total: " sum/count " seconds"}' "$RESULTS_FILE")

    echo ""
    echo "Flow 4 (Depot CI) Placeholder:"
    echo "  Expected: ~26-60 seconds"
    echo "  Re-run this script after Depot setup to get actual metrics"

    echo ""
    print_info "To add Depot CI benchmarks:"
    echo "  1. Sign up at depot.dev"
    echo "  2. Configure Depot CLI"
    echo "  3. Re-run this script (with Docker available)"

    echo ""
    print_header "Benchmark Complete!"
}

# Run main function
main "$@"
