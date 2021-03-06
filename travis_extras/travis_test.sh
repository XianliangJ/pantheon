#! /bin/bash -x

cp travis_extras/id_rsa ~/.ssh/id_rsa
cp travis_extras/id_rsa.pub ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# set up ssh multiplexing
cp travis_extras/travis_ssh_config ~/.ssh/config
mkdir -p ~/.ssh/controlmasters

test/run.py --run-only setup
mm-delay 100 sh -c 'ssh -o "StrictHostKeyChecking=no" $USER@$MAHIMAHI_BASE exit; $EXTRA_MAHIMAHI_SHELLS test/run.py --run-only test -t 15 -r $USER@$MAHIMAHI_BASE:build/StanfordLPNG/pantheon $RUN_PY_EXTRAS'
pip install matplotlib numpy
analyze/analyze.py --data-dir test
