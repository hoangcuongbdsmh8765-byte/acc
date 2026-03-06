-- 算命商业平台数据库初始化脚本
CREATE DATABASE IF NOT EXISTS fortune_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE fortune_db;

-- 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(200) NOT NULL COMMENT '密码',
    `nickname` VARCHAR(50) DEFAULT '' COMMENT '昵称',
    `avatar` VARCHAR(500) DEFAULT '' COMMENT '头像URL',
    `phone` VARCHAR(20) DEFAULT '' COMMENT '手机号',
    `email` VARCHAR(100) DEFAULT '' COMMENT '邮箱',
    `gender` TINYINT DEFAULT 0 COMMENT '性别 0未知 1男 2女',
    `birthday` DATE DEFAULT NULL COMMENT '出生日期',
    `vip_level` INT DEFAULT 0 COMMENT 'VIP等级 0普通 1月度 2年度',
    `vip_expire_time` DATETIME DEFAULT NULL COMMENT 'VIP到期时间',
    `coin_balance` INT DEFAULT 0 COMMENT '金币余额',
    `role` VARCHAR(20) DEFAULT 'USER' COMMENT '角色 USER/ADMIN',
    `status` TINYINT DEFAULT 1 COMMENT '状态 0禁用 1正常',
    `last_sign_date` DATE DEFAULT NULL COMMENT '最后签到日期',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB COMMENT='用户表';

-- VIP会员记录表
DROP TABLE IF EXISTS `vip_member`;
CREATE TABLE `vip_member` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `level` INT NOT NULL COMMENT 'VIP等级',
    `plan_type` VARCHAR(20) NOT NULL COMMENT '套餐类型 MONTHLY/YEARLY',
    `start_time` DATETIME NOT NULL,
    `expire_time` DATETIME NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB COMMENT='VIP会员记录';

-- 订单表
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `order_no` VARCHAR(50) NOT NULL COMMENT '订单号',
    `user_id` BIGINT NOT NULL,
    `product_type` VARCHAR(30) NOT NULL COMMENT '商品类型 VIP_MONTHLY/VIP_YEARLY/SINGLE_DETAIL',
    `product_name` VARCHAR(100) DEFAULT '' COMMENT '商品名称',
    `amount` DECIMAL(10,2) NOT NULL COMMENT '金额',
    `pay_method` VARCHAR(20) DEFAULT '' COMMENT '支付方式 WECHAT/ALIPAY/COIN',
    `status` TINYINT DEFAULT 0 COMMENT '0待支付 1已支付 2已取消 3已退款',
    `pay_time` DATETIME DEFAULT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB COMMENT='订单表';

-- 测算记录表
DROP TABLE IF EXISTS `fortune_record`;
CREATE TABLE `fortune_record` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `fortune_type` VARCHAR(20) NOT NULL COMMENT '类型 BAZI/ZODIAC/TAROT/NAME/DREAM/FACE/FENGSHUI/HUANGLI',
    `input_params` TEXT COMMENT '输入参数JSON',
    `result_content` LONGTEXT COMMENT '结果内容JSON',
    `is_detailed` TINYINT DEFAULT 0 COMMENT '是否详细版 0基础 1详细',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_type` (`fortune_type`)
) ENGINE=InnoDB COMMENT='测算记录';

-- 塔罗牌表
DROP TABLE IF EXISTS `tarot_card`;
CREATE TABLE `tarot_card` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name_cn` VARCHAR(50) NOT NULL COMMENT '中文名',
    `name_en` VARCHAR(50) NOT NULL COMMENT '英文名',
    `arcana` VARCHAR(10) NOT NULL COMMENT 'MAJOR/MINOR',
    `suit` VARCHAR(20) DEFAULT '' COMMENT '花色 Wands/Cups/Swords/Pentacles',
    `number` INT DEFAULT 0 COMMENT '编号',
    `image_url` VARCHAR(500) DEFAULT '',
    `upright_meaning` TEXT COMMENT '正位含义',
    `reversed_meaning` TEXT COMMENT '逆位含义',
    `keywords` VARCHAR(200) DEFAULT '' COMMENT '关键词',
    `element` VARCHAR(20) DEFAULT '' COMMENT '元素',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='塔罗牌';

-- 周公解梦词典
DROP TABLE IF EXISTS `dream_dict`;
CREATE TABLE `dream_dict` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `keyword` VARCHAR(50) NOT NULL COMMENT '梦境关键词',
    `category` VARCHAR(30) NOT NULL COMMENT '分类',
    `interpretation` TEXT NOT NULL COMMENT '解释',
    `good_bad` TINYINT DEFAULT 0 COMMENT '0中性 1吉 2凶',
    PRIMARY KEY (`id`),
    KEY `idx_keyword` (`keyword`),
    KEY `idx_category` (`category`)
) ENGINE=InnoDB COMMENT='解梦词典';

-- 星座运势表
DROP TABLE IF EXISTS `zodiac_fortune`;
CREATE TABLE `zodiac_fortune` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `zodiac_type` INT NOT NULL COMMENT '星座 1-12',
    `fortune_date` DATE NOT NULL,
    `period_type` VARCHAR(10) NOT NULL COMMENT 'DAILY/WEEKLY/MONTHLY',
    `overall_score` INT DEFAULT 50 COMMENT '综合评分0-100',
    `love_score` INT DEFAULT 50,
    `career_score` INT DEFAULT 50,
    `wealth_score` INT DEFAULT 50,
    `health_score` INT DEFAULT 50,
    `love_fortune` TEXT,
    `career_fortune` TEXT,
    `wealth_fortune` TEXT,
    `health_fortune` TEXT,
    `lucky_color` VARCHAR(20) DEFAULT '',
    `lucky_number` INT DEFAULT 0,
    `lucky_direction` VARCHAR(20) DEFAULT '',
    `summary` TEXT,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_zodiac_date_period` (`zodiac_type`, `fortune_date`, `period_type`)
) ENGINE=InnoDB COMMENT='星座运势';

-- 黄历表
DROP TABLE IF EXISTS `huangli`;
CREATE TABLE `huangli` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `solar_date` DATE NOT NULL COMMENT '公历日期',
    `lunar_year` INT DEFAULT 0,
    `lunar_month` INT DEFAULT 0,
    `lunar_day` INT DEFAULT 0,
    `lunar_date_cn` VARCHAR(30) DEFAULT '' COMMENT '农历中文',
    `is_leap_month` TINYINT DEFAULT 0 COMMENT '是否闰月',
    `ganzhi_year` VARCHAR(10) DEFAULT '',
    `ganzhi_month` VARCHAR(10) DEFAULT '',
    `ganzhi_day` VARCHAR(10) DEFAULT '',
    `zodiac_animal` VARCHAR(4) DEFAULT '' COMMENT '生肖',
    `yi` TEXT COMMENT '宜',
    `ji` TEXT COMMENT '忌',
    `chong` VARCHAR(30) DEFAULT '' COMMENT '冲',
    `sha` VARCHAR(10) DEFAULT '' COMMENT '煞',
    `jishen` VARCHAR(200) DEFAULT '' COMMENT '吉神',
    `xiongsha` VARCHAR(200) DEFAULT '' COMMENT '凶煞',
    `solar_term` VARCHAR(10) DEFAULT '' COMMENT '节气',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_solar_date` (`solar_date`)
) ENGINE=InnoDB COMMENT='黄历';

-- 系统配置表
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `config_key` VARCHAR(50) NOT NULL,
    `config_value` VARCHAR(500) NOT NULL,
    `description` VARCHAR(200) DEFAULT '',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_key` (`config_key`)
) ENGINE=InnoDB COMMENT='系统配置';

-- 插入管理员账号 密码: admin123
INSERT INTO `user` (`username`, `password`, `nickname`, `role`, `vip_level`, `coin_balance`) VALUES
('admin', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36Kz2q3Xo0eyMfA6SBjlSXy', '系统管理员', 'ADMIN', 2, 99999);

-- 插入塔罗牌数据（22张大阿卡纳）
INSERT INTO `tarot_card` (`name_cn`, `name_en`, `arcana`, `number`, `upright_meaning`, `reversed_meaning`, `keywords`, `element`) VALUES
('愚者', 'The Fool', 'MAJOR', 0, '新的开始、冒险精神、天真无邪、自由自在。代表着一段新旅程的开启，充满无限可能。', '鲁莽行事、不计后果、缺乏计划、冒险失败。提醒你需要更加谨慎。', '冒险,新开始,天真,自由', '风'),
('魔术师', 'The Magician', 'MAJOR', 1, '创造力、意志力、技能、自信。你拥有实现目标的一切资源和能力。', '操纵、欺骗、技能未发挥、缺乏自信。可能有人在欺骗你。', '创造,技能,意志,资源', '风'),
('女祭司', 'The High Priestess', 'MAJOR', 2, '直觉、潜意识、内在智慧、神秘。相信你内心深处的声音。', '缺乏直觉、隐藏的真相、表面化、忽视内心。', '直觉,智慧,神秘,潜意识', '水'),
('女皇', 'The Empress', 'MAJOR', 3, '丰收、母性、美丽、富足。代表创造力和生命力的丰盛时期。', '依赖他人、创造力受阻、过度放纵、忽视自我。', '丰收,母性,美丽,富足', '地'),
('皇帝', 'The Emperor', 'MAJOR', 4, '权威、结构、领导力、稳定。代表着秩序和掌控力。', '专制、过度控制、缺乏灵活、权威挑战。', '权威,领导,稳定,秩序', '火'),
('教皇', 'The Hierophant', 'MAJOR', 5, '传统、信仰、教育、指导。遵循传统智慧和道德准则。', '打破传统、非主流、教条主义、不良建议。', '传统,信仰,教育,指导', '地'),
('恋人', 'The Lovers', 'MAJOR', 6, '爱情、和谐、关系、选择。面临重要的感情或人生选择。', '失衡、不和谐、价值观冲突、错误选择。', '爱情,选择,和谐,关系', '风'),
('战车', 'The Chariot', 'MAJOR', 7, '胜利、决心、意志力、前进。通过坚定意志克服障碍取得成功。', '缺乏方向、失控、攻击性、挫败。', '胜利,决心,意志,前进', '水'),
('力量', 'Strength', 'MAJOR', 8, '勇气、内在力量、耐心、同情。以温和的力量克服困难。', '自我怀疑、缺乏勇气、软弱、失去信心。', '勇气,力量,耐心,同情', '火'),
('隐士', 'The Hermit', 'MAJOR', 9, '内省、独处、智慧、寻找真理。适合沉思和自我反省的时期。', '孤立、逃避现实、过度封闭、拒绝帮助。', '内省,智慧,独处,真理', '地'),
('命运之轮', 'Wheel of Fortune', 'MAJOR', 10, '转变、命运、好运、周期。命运的转折点，好运即将到来。', '厄运、抗拒改变、失控、不利转变。', '命运,转变,好运,周期', '火'),
('正义', 'Justice', 'MAJOR', 11, '公正、真相、因果、平衡。行为将得到公正的回报。', '不公正、逃避责任、不诚实、失衡。', '公正,真相,因果,平衡', '风'),
('倒吊人', 'The Hanged Man', 'MAJOR', 12, '牺牲、等待、新视角、放下。换个角度看问题会有新发现。', '拖延、无谓牺牲、抗拒放手、困境。', '牺牲,等待,视角,放下', '水'),
('死神', 'Death', 'MAJOR', 13, '结束、转变、新生、放下过去。旧事物的结束是新生的开始。', '抗拒改变、恐惧、停滞、无法放手。', '结束,转变,新生,放下', '水'),
('节制', 'Temperance', 'MAJOR', 14, '平衡、耐心、调和、适度。保持中庸之道，寻求内心平衡。', '失衡、过度、缺乏耐心、冲突。', '平衡,耐心,调和,适度', '火'),
('恶魔', 'The Devil', 'MAJOR', 15, '束缚、诱惑、物质主义、阴暗面。警惕不健康的执着和依赖。', '释放、克服诱惑、觉醒、重获自由。', '束缚,诱惑,物质,阴暗', '地'),
('塔', 'The Tower', 'MAJOR', 16, '突变、破坏、启示、觉醒。突如其来的变化打破旧有格局。', '恐惧改变、延迟灾难、避免不了的结局。', '突变,破坏,启示,觉醒', '火'),
('星星', 'The Star', 'MAJOR', 17, '希望、灵感、宁静、祝福。黑暗过后的希望之光。', '绝望、失去信心、脱离现实、失望。', '希望,灵感,宁静,祝福', '风'),
('月亮', 'The Moon', 'MAJOR', 18, '幻觉、直觉、不安、潜意识。事情并非表面看到的那样。', '恐惧释放、真相浮现、走出迷惑。', '幻觉,直觉,不安,潜意识', '水'),
('太阳', 'The Sun', 'MAJOR', 19, '快乐、成功、活力、光明。充满正能量和生命力的美好时期。', '短暂快乐、过度乐观、延迟成功。', '快乐,成功,活力,光明', '火'),
('审判', 'Judgement', 'MAJOR', 20, '觉醒、重生、评判、召唤。重新审视过去，迎接崭新的自己。', '自我怀疑、拒绝反省、逃避评判。', '觉醒,重生,评判,召唤', '火'),
('世界', 'The World', 'MAJOR', 21, '完成、成就、圆满、整合。一个周期的完美结束，功德圆满。', '未完成、缺乏结束、延迟完成、不圆满。', '完成,成就,圆满,整合', '地');

-- 插入解梦词典数据
INSERT INTO `dream_dict` (`keyword`, `category`, `interpretation`, `good_bad`) VALUES
('蛇', '动物', '梦见蛇通常代表智慧、诱惑或隐藏的恐惧。如果蛇攻击你，代表你正面临某种威胁；如果蛇温顺地盘绕，则代表智慧和治愈的力量。', 0),
('飞翔', '行为', '梦见飞翔代表自由、超越和渴望摆脱束缚。如果飞得很高，说明你充满自信；如果飞不起来，可能反映现实中的挫折感。', 1),
('掉牙', '身体', '梦见掉牙是很常见的梦，通常代表对衰老的恐惧、对外表的担忧，或者生活中正在经历某种损失或改变。', 2),
('水', '自然', '梦见水代表情感和潜意识。清澈的水象征平静和纯洁；浑浊的水则代表情感困扰和不安。', 0),
('火', '自然', '梦见火代表激情、愤怒或转变的力量。温暖的火代表温馨和希望；失控的大火则代表愤怒和危险。', 0),
('死人', '人物', '梦见死人并不一定是坏兆头，通常代表旧事物的结束和新生活的开始，也可能是对逝去亲人的思念。', 0),
('考试', '场景', '梦见考试通常反映你在现实中面临压力或评判的焦虑，担心自己的能力不够或表现不好。', 2),
('结婚', '场景', '梦见结婚通常代表人生新阶段的开始、承诺和合作关系。如果梦中感到快乐，预示好事将近。', 1),
('怀孕', '身体', '梦见怀孕不一定与实际怀孕有关，通常象征新想法、新计划的孕育，或创造力的萌发。', 1),
('猫', '动物', '梦见猫代表独立、直觉和女性力量。温顺的猫象征好运；野猫或攻击性的猫可能代表身边有不可信的人。', 0),
('狗', '动物', '梦见狗代表忠诚、友谊和保护。友善的狗象征忠实的朋友；凶恶的狗可能代表背叛或敌人。', 1),
('钱', '物品', '梦见钱通常反映你对安全感和自我价值的关注。捡到钱代表好运将至；丢钱则代表担忧和不安全感。', 1),
('下雨', '自然', '梦见下雨代表情感的释放和净化。小雨象征温柔和滋润；暴雨则可能代表压抑情绪的爆发。', 0),
('地震', '自然', '梦见地震代表生活中的巨大变动和不稳定感，可能预示着重大的改变即将发生。', 2),
('花', '植物', '梦见花代表美好、爱情和生命的绽放。盛开的花象征幸福和成功；枯萎的花则代表失落和结束。', 1),
('树', '植物', '梦见树代表生命力、成长和根基。茂盛的大树象征稳定和繁荣；枯树则代表需要重新审视生活方向。', 1),
('老虎', '动物', '梦见老虎代表力量、权威和勇气。骑虎代表你能驾驭困难局面；被虎追赶则代表你正在逃避某种压力。', 0),
('龙', '动物', '梦见龙在中国文化中是大吉之兆，代表权力、尊贵、好运和成功。龙飞天上更是预示事业腾飞。', 1),
('鬼', '人物', '梦见鬼通常代表内心深处的恐惧和不安，也可能是未处理的心理问题的投射。', 2),
('海', '自然', '梦见大海代表广阔的心胸和无限的可能性。平静的海面象征内心安宁；波涛汹涌则代表情绪起伏。', 0),
('山', '自然', '梦见山代表目标、挑战和成就。登上山顶象征成功和胜利；面对险峻的山路则代表前方困难重重。', 0),
('婴儿', '人物', '梦见婴儿代表纯真、新的开始和内心深处的脆弱。健康的婴儿象征好运和希望。', 1),
('车', '物品', '梦见车代表人生的方向和掌控力。开车顺畅代表生活如意；失控则代表对生活失去控制感。', 0),
('房子', '场景', '梦见房子代表自我和内心世界。新房代表新生活；旧房或破损的房子代表需要关注的内在问题。', 0),
('吃饭', '行为', '梦见吃饭代表满足感和营养的补充。美食代表生活满足；吃不到或食物变质代表某种匮乏感。', 1),
('跑步', '行为', '梦见跑步代表你正在追求某个目标或逃避某种状况。跑得快代表进展顺利；跑不动则反映焦虑。', 0),
('打架', '行为', '梦见打架代表内心冲突或与他人的矛盾。打赢代表克服困难；打输则提醒需要改变策略。', 0),
('血', '身体', '梦见血代表生命力和能量。少量的血可能代表损失；大量鲜血则可能预示重大变化或激情。', 0),
('鱼', '动物', '梦见鱼在中国传统中代表富裕和吉祥，是好兆头。抓到鱼代表获得财富；鱼跳龙门更是大吉。', 1),
('太阳', '自然', '梦见太阳代表光明、希望、活力和成功。旭日东升象征新的开始和好运。', 1);

-- 插入系统配置
INSERT INTO `sys_config` (`config_key`, `config_value`, `description`) VALUES
('free_daily_limit', '3', '每日免费测算次数'),
('vip_monthly_price', '29.9', '月度VIP价格'),
('vip_yearly_price', '199', '年度VIP价格'),
('sign_coin_reward', '10', '每日签到奖励金币'),
('detail_coin_cost', '50', '详细解读消耗金币'),
('share_coin_reward', '5', '分享奖励金币');
