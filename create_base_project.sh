#!/bin/sh

# Usage: ./create_base_project.sh --project=myproject
# If no project name is provided, default "project" will be used

STM32_FAMILY=STM32F1xx
STM32_CHIP=STM32F103x6
SRC_DIR=src
INC_DIR=inc
LIBS_DIR=libs
STARTUP_DIR=startup
LINKER_DIR=linker
STM32_BASE_REPO=https://raw.githubusercontent.com/STM32-base/STM32-base/refs/heads/master/
STM32_BASE_REPO_STARTUP=${STM32_BASE_REPO}/startup
STM32_BASE_REPO_LINKER=${STM32_BASE_REPO}/linker

project_name="project"

# Function to display help message
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -p, --project NAME   Specify the project name (default: \"project\")"
    echo "  -h, --help           Display this help message and exit"
    echo
    echo "Examples:"
    echo "  $0 --project=myapp   Run with project name \"myapp\""
}

error(){
    echo "$1"
    exit 1
}

# Parse command line arguments
options=$(getopt -o p:h --long project:,help -n 'parse-options' -- "$@")

if [ $? != 0 ]; then
    show_help
    exit 1
fi

# Set the parsed options back as positional parameters
eval set -- "$options"

# Process the option
while true; do
    case "$1" in
        -p | --project)
            project_name="$2"
            shift 2
            ;;
        -h | --help)
            show_help
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal error!"
            exit 1
            ;;
    esac
done

mkdir -p "${project_name}/${SRC_DIR}" \
    "${project_name}/${INC_DIR}" \
    "${project_name}/${LIBS_DIR}" \
    "${project_name}/${STARTUP_DIR}" \
    "${project_name}/${LINKER_DIR}"

# Download required files
wget -q $STM32_BASE_REPO_STARTUP/startup_common.s -P "${project_name}"/${STARTUP_DIR} || error "Download failed"
wget -q $STM32_BASE_REPO_STARTUP/$STM32_FAMILY/$STM32_CHIP.s -P "${project_name}"/${STARTUP_DIR} || error "Download failed"
wget -q $STM32_BASE_REPO_LINKER/common.ld -P "${project_name}"/${LINKER_DIR} || error "Download failed"
wget -q $STM32_BASE_REPO_LINKER/$STM32_FAMILY/$STM32_CHIP.ld -P "${project_name}"/${LINKER_DIR} || error "Download failed"

# Display the project name being used
echo "Create project: $project_name"
