#!/bin/bash
source ./.env
source ./${APPNAME_1090}/${APPNAME_1090}.env
TIMESTAMP="date --rfc-3339=seconds"

echo "[start build ${APPNAME_1090}]`${TIMESTAMP}`"
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --no-cache)
      NO_CACHE="$1"
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

docker compose down

docker compose build \
 ${NO_CACHE} \
 --build-arg REPOSITORY="${ARG_1090_REPOSITORY}" \
 --build-arg PROJECT="${ARG_1090_PROJECT}" \
 --build-arg BRANCH="${ARG_1090_BRANCH}" \
 --force-rm \
${APPNAME_1090}

echo "[finish build ${APPNAME_1090}]`${TIMESTAMP}`"
