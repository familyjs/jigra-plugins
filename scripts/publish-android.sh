#!/usr/bin/env bash

# The default Jigra version(s) the plugin should depend on. Latest published in a range will be pulled by the user
DEFAULT_JIGRA_VERSION="[5.0,6.0)"

publish_plugin () {
    PLUGIN_PATH=$1
    if [ -d "$PLUGIN_PATH" ]; then
        # Android dir path
        ANDROID_PATH=$PLUGIN_PATH/android
        GRADLE_FILE=$ANDROID_PATH/build.gradle

        # Only try to publish if the directory contains a package.json and android package
        if test -f "$PLUGIN_PATH/package.json" && test -d "$ANDROID_PATH" && test -f "$GRADLE_FILE"; then
            PLUGIN_VERSION=$(grep '"version": ' "$PLUGIN_PATH"/package.json | awk '{print $2}' | tr -d '",')
            PLUGIN_NAME=$(grep '"name": ' "$PLUGIN_PATH"/package.json | awk '{print $2}' | tr -d '",')
            PLUGIN_NAME=${PLUGIN_NAME#@jigra/}
            LOG_OUTPUT=./tmp/$PLUGIN_NAME.txt

            # Get latest plugin info from MavenCentral
            PLUGIN_PUBLISHED_URL="https://repo1.maven.org/maven2/com/jigrajs/$PLUGIN_NAME/maven-metadata.xml"
            PLUGIN_PUBLISHED_DATA=$(curl -s $PLUGIN_PUBLISHED_URL)
            PLUGIN_PUBLISHED_VERSION="$(perl -ne 'print and last if s/.*<latest>(.*)<\/latest>.*/\1/;' <<< $PLUGIN_PUBLISHED_DATA)"

            if [[ $PLUGIN_VERSION == $PLUGIN_PUBLISHED_VERSION ]]; then
                printf %"s\n\n" "Duplicate: a published plugin $PLUGIN_NAME exists for version $PLUGIN_VERSION, skipping..."
            else
                # Make log dir if doesnt exist
                mkdir -p ./tmp

                printf %"s\n" "Attempting to build and publish plugin $PLUGIN_NAME for version $PLUGIN_VERSION to production..."

                # Export ENV variables used by Gradle for the plugin
                export PLUGIN_NAME
                export PLUGIN_VERSION
                export JIGRA_VERSION
                export JIG_PLUGIN_PUBLISH=true

                # Build and publish
                "$ANDROID_PATH"/gradlew clean build publishReleasePublicationToSonatypeRepository closeAndReleaseSonatypeStagingRepository --no-daemon --max-workers 1 -b "$ANDROID_PATH"/build.gradle -Pandroid.useAndroidX=true > $LOG_OUTPUT 2>&1

                if grep --quiet "BUILD SUCCESSFUL" $LOG_OUTPUT; then
                    printf %"s\n\n" "Success: $PLUGIN_NAME published to MavenCentral."
                else
                    printf %"s\n\n" "Error publishing $PLUGIN_NAME, check $LOG_OUTPUT for more info! Manual publication review may be necessary at the Sonatype Repository Manager https://s01.oss.sonatype.org/"
                    cat $LOG_OUTPUT
                    exit 1
                fi
            fi
        else
            printf %"s\n\n" "$PLUGIN_PATH does not appear to be a plugin (has no package.json file or Android package), skipping..."
        fi
    fi
}

# Plugins base location
DIR=..

# Get latest com.jigrajs:core XML version info
JIGRA_PUBLISHED_URL="https://repo1.maven.org/maven2/com/jigrajs/core/maven-metadata.xml"
JIGRA_PUBLISHED_DATA=$(curl -s $JIGRA_PUBLISHED_URL)
JIGRA_PUBLISHED_VERSION="$(perl -ne 'print and last if s/.*<latest>(.*)<\/latest>.*/\1/;' <<< $JIGRA_PUBLISHED_DATA)"

printf %"s\n" "The latest published Android library version of Jigra Core is $JIGRA_PUBLISHED_VERSION in MavenCentral."

# Check if github actions passing in a custom native Jigra dependency version
if [[ $GITHUB_JIGRA_VERSION ]]; then
    JIGRA_VERSION=$GITHUB_JIGRA_VERSION
else
    JIGRA_VERSION=$DEFAULT_JIGRA_VERSION
fi

printf %"s\n" "Publishing plugin(s) with dependency on Jigra version $JIGRA_VERSION"

# Check if github actions passing in a custom list of plugins
if [[ $GITHUB_PLUGINS ]]; then
    for var in ${GITHUB_PLUGINS[@]}; do
        PLUGIN_DIR="$DIR"/$var
        publish_plugin $PLUGIN_DIR
    done
else
    # If run without .sh args, process all plugins, else run over the plugins provided as args
    if [[ "$#" -eq  "0" ]]; then
        # Run publish task for all plugins
        for f in "$DIR"/*; do
            publish_plugin $f
        done
    else
        # Run publish task for plugins provided as arguments
        for var in "$@"; do
            PLUGIN_DIR="$DIR"/$var
            publish_plugin $PLUGIN_DIR
        done
    fi
fi

################################################
# old below - for reference only

# # Get the latest version of Jigra
# JIGRA_PACKAGE_JSON="https://raw.githubusercontent.com/familyjs/jigra/main/android/package.json"
# JIGRA_VERSION=$(curl -s $JIGRA_PACKAGE_JSON | awk -F\" '/"version":/ {print $4}')

# # Don't continue if there was a problem getting the latest version of Jigra
# if [[ $JIGRA_VERSION ]]; then
#     printf %"s\n\n" "Attempting to publish new plugins with dependency on Jigra Version $JIGRA_VERSION"
# else
#     printf %"s\n\n" "Error resolving latest Jigra version from $JIGRA_PACKAGE_JSON"
#     exit 1
# fi

# # Check if we need to publish a new native version of the Jigra Android library
# if [[ "$JIGRA_VERSION" != "$JIGRA_PUBLISHED_VERSION" ]]; then
#     printf %"s\n" "Publish Jigra Core first! The latest published Android library version $JIGRA_PUBLISHED_VERSION in MavenCentral is outdated. There is an unpublished version $JIGRA_VERSION in familyjs/jigra."
#     exit 1
# else
#     # Jigra version in MavenCentral is up to date, continue publishing the native Jigra Plugins
#     printf %"s\n\n" "Latest native Jigra Android library is version $JIGRA_PUBLISHED_VERSION and is up to date, continuing with plugin publishing..."

#     # Check if github actions passing in a custom list of plugins
#     if [[ $GITHUB_PLUGINS ]]; then
#         for var in ${GITHUB_PLUGINS[@]}; do
#             PLUGIN_DIR="$DIR"/$var
#             publish_plugin $PLUGIN_DIR
#         done
#     else
#         # If run without .sh args, process all plugins, else run over the plugins provided as args
#         if [[ "$#" -eq  "0" ]]; then
#             # Run publish task for all plugins
#             for f in "$DIR"/*; do
#                 publish_plugin $f
#             done
#         else
#             # Run publish task for plugins provided as arguments
#             for var in "$@"; do
#                 PLUGIN_DIR="$DIR"/$var
#                 publish_plugin $PLUGIN_DIR
#             done
#         fi
#     fi
# fi
