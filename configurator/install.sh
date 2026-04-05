source ./dependency_versions.sh

read -p "Which language? (ts): " language
read -p "Which environment? (node|next): " environment

npm install -D --save-exact "typescript@$dep_ver_typescript"

npm install -D --save-exact "prettier@$dep_ver_prettier"

npm install -D --save-exact "eslint@$dep_ver_eslint"
npm install -D --save-exact "typescript-eslint@$dep_ver_typescript-eslint"
npm install -D --save-exact "eslint-config-prettier@$dep_ver_eslint-config-prettier"
npm install -D --save-exact "eslint-plugin-simple-import-sort@$dep_ver_eslint-plugin-simple-import-sort"


prettier_config_file=./configs/prettierrc 
eslint_config_file=./configs/eslint-typescript-node.config.mjs

cp $prettier_config_file "$target_dir/.prettierrc"
cp $eslint_config_file "$target_dir/.eslint.config.mjs"

echo "Setup complete!"