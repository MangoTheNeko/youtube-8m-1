percent="$1"

CUDA_VISIBLE_DEVICES=0 python train.py \
	--train_dir="../model/distillation_video_dcc_noise/scene2_percent_${percent}" \
	--train_data_pattern="/Youtube-8M/distillation/video/train/*.tfrecord" \
  --distillation_features=True \
  --distillation_type=2 \
  --distillation_percent=${percent} \
	--model=DeepCombineChainModel \
	--label_loss=MultiTaskCrossEntropyLoss \
	--deep_chain_relu_cells=256 \
	--deep_chain_layers=4 \
	--moe_num_mixtures=4 \
	--frame_features=False \
	--feature_names="mean_rgb,mean_audio" \
	--feature_sizes="1024,128" \
	--multitask=True \
	--support_type="label,label,label,label" \
	--num_supports=18864 \
	--support_loss_percent=0.05 \
	--keep_checkpoint_every_n_hour=0.25 \
	--base_learning_rate=0.01 \
	--data_augmenter=NoiseAugmenter \
	--input_noise_level=0.1 \
  --reweight=True \
  --sample_vocab_file="resources/train.video_id.vocab" \
  --sample_freq_file="resources/train.video_id.freq" \
	--num_readers=8 \
	--num_epochs=6 \
	--batch_size=1024
