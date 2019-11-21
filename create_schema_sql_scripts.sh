#!/usr/bin/env bash

java -jar ${ILI2PG_PATH} \
--dbschema agi_dm01avso24 --models DM01AVSO24LV95 \
--strokeArcs --createFk --createFkIdx --createGeomIdx --createTidCol --createBasketCol --createDatasetCol --nameByTopic --createImportTabs --createMetaInfo --defaultSrsCode 2056 --createNumChecks \
--createscript sql/agi_dm01avso24.sql

# Append all SQL scripts to one single setup script
cat sql/setup_original.sql sql/set_role.sql sql/begin_transaction.sql \
sql/agi_dm01avso24.sql \
sql/views.sql \
sql/commit_transaction.sql > pgconf/setup.sql
