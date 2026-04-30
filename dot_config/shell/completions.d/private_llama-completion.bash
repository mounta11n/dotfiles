_llama_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    opts="-h --help --usage --version -cl --cache-list --completion-bash --verbose-prompt -t --threads -tb --threads-batch -C --cpu-mask -Cr --cpu-range --cpu-strict --prio --poll -Cb --cpu-mask-batch -Crb --cpu-range-batch --cpu-strict-batch --prio-batch --poll-batch -c --ctx-size -n --predict --n-predict -b --batch-size -ub --ubatch-size --keep --swa-full --kv-unified -kvu -fa --flash-attn -p --prompt --no-perf -f --file -bf --binary-file -e --escape --no-escape --rope-scaling --rope-scale --rope-freq-base --rope-freq-scale --yarn-orig-ctx --yarn-ext-factor --yarn-attn-factor --yarn-beta-slow --yarn-beta-fast -nkvo --no-kv-offload -nr --no-repack --no-host -ctk --cache-type-k -ctv --cache-type-v -dt --defrag-thold -np --parallel --mlock --no-mmap --numa -dev --device --list-devices --override-tensor -ot --cpu-moe -cmoe --n-cpu-moe -ncmoe -ngl --gpu-layers --n-gpu-layers -sm --split-mode -ts --tensor-split -mg --main-gpu --check-tensors --override-kv --no-op-offload --lora --lora-scaled --control-vector --control-vector-scaled --control-vector-layer-range -m --model -mu --model-url -dr --docker-repo -hf -hfr --hf-repo -hfd -hfrd --hf-repo-draft -hff --hf-file -hfv -hfrv --hf-repo-v -hffv --hf-file-v -hft --hf-token --log-disable --log-file --log-colors -v --verbose --log-verbose --offline -lv --verbosity --log-verbosity --log-prefix --log-timestamps -ctkd --cache-type-k-draft -ctvd --cache-type-v-draft --samplers -s --seed --sampling-seq --sampler-seq --ignore-eos --temp --top-k --top-p --min-p --top-nsigma --xtc-probability --xtc-threshold --typical --repeat-last-n --repeat-penalty --presence-penalty --frequency-penalty --dry-multiplier --dry-base --dry-allowed-length --dry-penalty-last-n --dry-sequence-breaker --dynatemp-range --dynatemp-exp --mirostat --mirostat-lr --mirostat-ent -l --logit-bias --grammar --grammar-file -j --json-schema -jf --json-schema-file --no-display-prompt -co --color --no-context-shift --context-shift -sys --system-prompt -sysf --system-prompt-file -ptc --print-token-count --prompt-cache --prompt-cache-all --prompt-cache-ro -r --reverse-prompt -sp --special -cnv --conversation -no-cnv --no-conversation -st --single-turn -i --interactive -if --interactive-first -mli --multiline-input --in-prefix-bos --in-prefix --in-suffix --no-warmup -gan --grp-attn-n -gaw --grp-attn-w --jinja --reasoning-format --reasoning-budget --chat-template --chat-template-file --simple-io "

    case "$prev" in
        --model|-m)
            COMPREPLY=( $(compgen -f -X '!*.gguf' -- "$cur") $(compgen -d -- "$cur") )
            return 0
            ;;
        --grammar-file)
            COMPREPLY=( $(compgen -f -X '!*.gbnf' -- "$cur") $(compgen -d -- "$cur") )
            return 0
            ;;
        --chat-template-file)
            COMPREPLY=( $(compgen -f -X '!*.jinja' -- "$cur") $(compgen -d -- "$cur") )
            return 0
            ;;
        *)
            COMPREPLY=( $(compgen -W "${opts}" -- "$cur") )
            return 0
            ;;
    esac
}

complete -F _llama_completions llama-batched
complete -F _llama_completions llama-batched-bench
complete -F _llama_completions llama-bench
complete -F _llama_completions llama-cli
complete -F _llama_completions llama-convert-llama2c-to-ggml
complete -F _llama_completions llama-cvector-generator
complete -F _llama_completions llama-embedding
complete -F _llama_completions llama-eval-callback
complete -F _llama_completions llama-export-lora
complete -F _llama_completions llama-gen-docs
complete -F _llama_completions llama-gguf
complete -F _llama_completions llama-gguf-hash
complete -F _llama_completions llama-gguf-split
complete -F _llama_completions llama-gritlm
complete -F _llama_completions llama-imatrix
complete -F _llama_completions llama-infill
complete -F _llama_completions llama-llava-clip-quantize-cli
complete -F _llama_completions llama-lookahead
complete -F _llama_completions llama-lookup
complete -F _llama_completions llama-lookup-create
complete -F _llama_completions llama-lookup-merge
complete -F _llama_completions llama-lookup-stats
complete -F _llama_completions llama-mtmd-cli
complete -F _llama_completions llama-parallel
complete -F _llama_completions llama-passkey
complete -F _llama_completions llama-perplexity
complete -F _llama_completions llama-q8dot
complete -F _llama_completions llama-quantize
complete -F _llama_completions llama-qwen2vl-cli
complete -F _llama_completions llama-retrieval
complete -F _llama_completions llama-run
complete -F _llama_completions llama-save-load-state
complete -F _llama_completions llama-server
complete -F _llama_completions llama-simple
complete -F _llama_completions llama-simple-chat
complete -F _llama_completions llama-speculative
complete -F _llama_completions llama-speculative-simple
complete -F _llama_completions llama-tokenize
complete -F _llama_completions llama-tts
complete -F _llama_completions llama-vdot
