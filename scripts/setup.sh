#!/bin/bash

# Depot + Railway Demo Setup Script
# This script automates the setup process for the Depot CI showcase

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="openclaw-demo"
DEPOT_PROJECT_ID=""
RAILWAY_PROJECT_ID=""
RAILWAY_SERVICE_ID=""

# Helper functions
print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_step() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

check_command() {
    if command -v $1 &> /dev/null; then
        print_step "$1 is installed"
        return 0
    else
        print_warning "$1 is not installed"
        return 1
    fi
}

# Main setup process
main() {
    print_header "Depot + Railway Demo Setup"

    # Check prerequisites
    print_header "Step 1: Checking Prerequisites"

    MISSING_DEPS=0

    if ! check_command "node"; then
        MISSING_DEPS=1
    fi

    if ! check_command "npm"; then
        MISSING_DEPS=1
    fi

    if ! check_command "docker"; then
        MISSING_DEPS=1
    fi

    if ! check_command "git"; then
        MISSING_DEPS=1
    fi

    if [ $MISSING_DEPS -eq 1 ]; then
        print_error "Missing required dependencies. Please install them and run again."
        exit 1
    fi

    # Install sample app dependencies
    print_header "Step 2: Installing Sample App Dependencies"
    cd sample-app
    npm install
    print_step "Dependencies installed"
    cd ..

    # Check for Depot CLI
    print_header "Step 3: Checking Depot CLI"

    if check_command "depot"; then
        print_step "Depot CLI is installed"
        depot --version
    else
        print_warning "Depot CLI not found"
        echo "Install with: curl -L https://depot.dev/install.sh | sh"
        echo "Then add to PATH: export PATH=\$PATH:\$HOME/.depot/bin"
    fi

    # Check for Railway CLI
    print_header "Step 4: Checking Railway CLI"

    if check_command "railway"; then
        print_step "Railway CLI is installed"
        railway --version
    else
        print_warning "Railway CLI not found"
        echo "Install with: npm install -g @railway/cli"
        echo "Or: curl -sSL https://railway.app/install.sh | sh"
    fi

    # Build sample app
    print_header "Step 5: Building Sample App"
    cd sample-app
    npm run build
    print_step "Build complete"
    cd ..

    # Test Docker build
    print_header "Step 6: Testing Docker Build"
    docker build -t $PROJECT_NAME:latest ./sample-app
    print_step "Docker image built successfully"

    # Display next steps
    print_header "Setup Complete!"
    echo -e "${GREEN}Next steps:${NC}"
    echo ""
    echo "1. Sign up for Depot at: https://depot.dev"
    echo "2. Sign up for Railway at: https://railway.app"
    echo "3. Configure GitHub secrets (see docs/github-secrets.md)"
    echo "4. Run the baseline workflow: railway-direct.yml"
    echo "5. Run the Depot CI workflow: depot-ci.yml"
    echo ""
    echo -e "${BLUE}For detailed instructions, see docs/setup-guide.md${NC}\n"
}

# Run main function
main "$@"
