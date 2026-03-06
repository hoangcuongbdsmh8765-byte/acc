package com.fortune.common;

public class Constants {

    public static final String TOKEN_HEADER = "Authorization";
    public static final String TOKEN_PREFIX = "Bearer ";

    public static final String ROLE_USER = "USER";
    public static final String ROLE_ADMIN = "ADMIN";

    public static final class FortuneType {
        public static final String BAZI = "BAZI";
        public static final String ZODIAC = "ZODIAC";
        public static final String TAROT = "TAROT";
        public static final String NAME = "NAME";
        public static final String DREAM = "DREAM";
        public static final String FACE = "FACE";
        public static final String FENGSHUI = "FENGSHUI";
        public static final String HUANGLI = "HUANGLI";
    }

    public static final class OrderStatus {
        public static final int PENDING = 0;
        public static final int PAID = 1;
        public static final int CANCELLED = 2;
        public static final int REFUNDED = 3;
    }

    public static final class VipLevel {
        public static final int NORMAL = 0;
        public static final int MONTHLY = 1;
        public static final int YEARLY = 2;
    }

    public static final class ProductType {
        public static final String VIP_MONTHLY = "VIP_MONTHLY";
        public static final String VIP_YEARLY = "VIP_YEARLY";
        public static final String SINGLE_DETAIL = "SINGLE_DETAIL";
    }
}
