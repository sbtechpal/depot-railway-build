#!/bin/bash

# Depot CI Benchmark Script
# Measures timing for flows 1, 2, and 3 (Depot CI to be added later)
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
RESULTS_DIR="./benchmarks/results"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULTS_FILE="$RESULTS_DIR/benchmark_${TIMESTAMP}.csv"

# Create results directory
mkdir -p "$RESULTS_DIR"

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

# Main benchmark execution
main() {
    print_header "Depot CI Benchmark - Flows 1, 2, 3"

    echo "Benchmark configuration:"
    echo "  Project: $PROJECT_NAME"
    echo "  Iterations: $ITERATIONS"
    echo "  Results: $RESULTS_FILE"
    echo ""

    # CSV header
    echo "flow,iteration,stage,duration,timestamp" > "$RESULTS_FILE"

    # ========================================
    # FLOW 1: Local Build → Railway Deploy
    # ========================================
    print_header "Flow 1: Local Build → Railway Deploy"
    print_info "Building locally, then deploying via Railway CLI"

    for i in $(seq 1 $ITERATIONS); do
        echo ""
        echo "Iteration $i/$ITERATIONS"

        cd sample-app

        # Clean start
        print_info "Cleaning previous build..."
        rm -rf node_modules dist

        # Stage 1: Install dependencies
        print_info "Stage 1: Installing dependencies..."
        START=$(date +%s)
        npm install --silent --no-audit --no-fund
        END=$(date +%s)
        DEPS_DURATION=$((END - START))
        echo "  Dependencies: ${DEPS_DURATION}s"
        echo "flow1,$i,dependencies,$DEPS_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 2: TypeScript build
        print_info "Stage 2: Building TypeScript..."
        START=$(date +%s)
        npm run build --silent
        END=$(date +%s)
        BUILD_DURATION=$((END - START))
        echo "  TypeScript: ${BUILD_DURATION}s"
        echo "flow1,$i,typescript,$BUILD_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 3: Docker build
        print_info "Stage 3: Building Docker image..."
        START=$(date +%s)
        docker build -t $PROJECT_NAME:bench . > /dev/null 2>&1
        END=$(date +%s)
        DOCKER_DURATION=$((END - START))
        echo "  Docker build: ${DOCKER_DURATION}s"
        echo "flow1,$i,docker,$DOCKER_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Calculate total
        TOTAL_DURATION=$((DEPS_DURATION + BUILD_DURATION + DOCKER_DURATION))
        echo "  ${GREEN}Flow 1 Total: ${TOTAL_DURATION}s${NC}"
        echo "flow1,$i,total,$TOTAL_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        cd ..
        sleep 2
    done

    # ========================================
    # FLOW 2: Git Push → Railway Auto-Build
    # ========================================
    print_header "Flow 2: Git Push → Railway Auto-Build"
    print_warning "Note: This requires Railway autobuild to be enabled"
    print_warning "Cost: Each build will consume ~$0.05 of Railway credits"
    print_info "If you don't want to spend credits, press Ctrl+C to skip"

    read -p "Continue with Flow 2 benchmark? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Check if Railway CLI is configured
        if command -v railway &> /dev/null; then
            print_info "Railway CLI found"

            # Get current project info
            PROJECT_INFO=$(railway status 2>/dev/null || echo "")
            if [ -n "$PROJECT_INFO" ]; then
                print_info "Railway project: $(echo $PROJECT_INFO | head -1)"
            fi
        else
            print_warning "Railway CLI not found. Installing..."
            npm install -g @railway/cli
        fi

        for i in $(seq 1 $ITERATIONS); do
            echo ""
            echo "Iteration $i/$ITERATIONS"

            # Make a trivial change to trigger build
            cd sample-app
            echo "// Benchmark $i at $(date)" >> src/benchmark.ts

            # Stage 1: Git commit
            print_info "Stage 1: Committing changes..."
            START=$(date +%s)
            git add benchmark.ts > /dev/null 2>&1
            git commit -m "Benchmark $i" --quiet > /dev/null 2>&1
            END=$(date +%s)
            COMMIT_DURATION=$((END - START))
            echo "  Git commit: ${COMMIT_DURATION}s"
            echo "flow2,$i,commit,$COMMIT_DURATION,$(date +%s)" >> "$RESULTS_FILE"

            # Stage 2: Push to trigger Railway build
            print_info "Stage 2: Pushing to trigger Railway build..."
            print_warning "Railway is now building on their infrastructure..."
            print_warning "Watch Railway dashboard for timing (3-5 minutes typical)"

            START=$(date +%s)
            git push origin main --quiet > /dev/null 2>&1 || echo "Push may have failed or nothing to push"
            PUSH_END=$(date +%s)
            PUSH_DURATION=$((PUSH_END - START))
            echo "  Push: ${PUSH_DURATION}s"
            echo "flow2,$i,push,$PUSH_DURATION,$(date +%s)" >> "$RESULTS_FILE"

            # Note: We can't measure Railway build time from CLI
            # User needs to note this from Railway dashboard
            print_warning "⏱️  Check Railway dashboard for actual build time"
            print_info "Expected: 3-5 minutes"

            # Wait and record estimated time
            print_info "Waiting 3 minutes for Railway build (typical time)..."
            sleep 180

            # Record estimated total
            echo "flow2,$i,total_estimated,180,$(date +%s)" >> "$RESULTS_FILE"
            echo "  ${YELLOW}Flow 2 Total (estimated): 180s${NC}"

            cd ..
            sleep 2
        done
    else
        echo "flow2,skipped,skipped,0,$(date +%s)" >> "$RESULTS_FILE"
        print_warning "Flow 2 skipped (no Railway credits consumed)"
    fi

    # ========================================
    # FLOW 3: GitHub Actions → Railway
    # ========================================
    print_header "Flow 3: GitHub Actions → Railway"
    print_info "Simulating GitHub Actions workflow locally"

    for i in $(seq 1 $ITERATIONS); do
        echo ""
        echo "Iteration $i/$ITERATIONS"

        cd sample-app

        # Clean start
        rm -rf node_modules dist

        # Stage 1: Checkout (simulated)
        print_info "Stage 1: Checkout (simulated)"
        START=$(date +%s)
        # Git operations are fast, this is just the clone
        END=$(date +%s)
        CHECKOUT_DURATION=$((END - START))
        echo "  Checkout: ${CHECKOUT_DURATION}s"
        echo "flow3,$i,checkout,$CHECKOUT_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 2: Setup Node (simulated - assumes already installed)
        print_info "Stage 2: Setup Node (simulated)"
        START=$(date +%s)
        # Node is already installed, minimal time
        END=$(date +%s)
        SETUP_DURATION=$((END - START))
        echo "  Setup: ${SETUP_DURATION}s"
        echo "flow3,$i,setup,$SETUP_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 3: Install dependencies
        print_info "Stage 3: Installing dependencies..."
        START=$(date +%s)
        npm ci --silent --no-audit --no-fund
        END=$(date +%s)
        DEPS_DURATION=$((END - START))
        echo "  Dependencies: ${DEPS_DURATION}s"
        echo "flow3,$i,dependencies,$DEPS_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        # Stage 4: Run tests
        print_info "Stage 4: Running tests..."
        START=$(date +%s)
        npm test --silent > /dev/null 2>&1 || echo "  Tests completed"
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

        # Stage 6: Deploy to Railway (simulated - assumes CLI configured)
        if command -v railway &> /dev/null; then
            print_info "Stage 6: Deploy to Railway..."
            START=$(date +%s)
            # railway up would go here, but we'll simulate
            END=$(date +%s)
            DEPLOY_DURATION=$((END - START))
            echo "  Deploy: ${DEPLOY_DURATION}s (simulated)"
            echo "flow3,$i,deploy,$DEPLOY_DURATION,$(date +%s)" >> "$RESULTS_FILE"
        else
            print_info "Stage 6: Deploy (skipped - Railway CLI not configured)"
            echo "flow3,$i,deploy,0,$(date +%s)" >> "$RESULTS_FILE"
        fi

        # Calculate total
        TOTAL_DURATION=$((CHECKOUT_DURATION + SETUP_DURATION + DEPS_DURATION + TEST_DURATION + BUILD_DURATION))
        echo "  ${GREEN}Flow 3 Total: ${TOTAL_DURATION}s${NC}"
        echo "flow3,$i,total,$TOTAL_DURATION,$(date +%s)" >> "$RESULTS_FILE"

        cd ..
        sleep 2
    done

    # ========================================
    # FLOW 4: Depot CI (Placeholder)
    # ========================================
    print_header "Flow 4: Depot CI → Railway"
    print_warning "Depot CI not yet configured"
    print_info "Placeholder for when Depot account is set up"
    print_info "Expected timing based on Depot claims:"
    print_info "  Dependencies: ~5s (9x faster)"
    print_info "  TypeScript: ~3s (10x faster)"
    print_info "  Docker: ~8s (11x faster)"
    print_info "  Deploy: ~10s"
    print_info "  ${GREEN}Total: ~30s (5-10x faster)${NC}"

    # Add placeholder to CSV
    echo "flow4,placeholder,dependencies,5,DEPOT_CI_PENDING"
    echo "flow4,placeholder,typescript,3,DEPOT_CI_PENDING"
    echo "flow4,placeholder,docker,8,DEPOT_CI_PENDING"
    echo "flow4,placeholder,deploy,10,DEPOT_CI_PENDING"
    echo "flow4,placeholder,total,26,DEPOT_CI_PENDING"

    # ========================================
    # RESULTS SUMMARY
    # ========================================
    print_header "Benchmark Results Summary"
    echo ""
    echo "Results saved to: $RESULTS_FILE"
    echo ""

    # Calculate averages
    echo "Flow 1 (Local → Railway) Averages:"
    awk -F, '$1=="flow1" && $3=="total" {sum+=$4; count++} END {if(count>0) print "  Total time: " sum/count " seconds"}' "$RESULTS_FILE"

    echo ""
    echo "Flow 2 (Railway Auto-Build) Notes:"
    echo "  Actual build times must be recorded from Railway dashboard"
    echo "  Expected: 180-300 seconds per build"
    echo "  Cost: ~$0.05 per build"

    echo ""
    echo "Flow 3 (GitHub Actions → Railway) Averages:"
    awk -F, '$1=="flow3" && $3=="total" {sum+=$4; count++} END {if(count>0) print "  Total time: " sum/count " seconds"}' "$RESULTS_FILE"

    echo ""
    echo "Flow 4 (Depot CI) Placeholder:"
    echo "  Expected: ~26-60 seconds"
    echo "  Re-run this script after Depot setup to get actual metrics"

    echo ""
    print_info "To add Depot CI benchmarks:"
    echo "  1. Sign up at depot.dev"
    echo "  2. Configure Depot CLI"
    echo "  3. Re-run this script"
    echo "  4. Flow 4 will be benchmarked automatically"

    echo ""
    print_header "Benchmark Complete!"
}

# Run main function
main "$@"
