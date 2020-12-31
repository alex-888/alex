package alex.lib;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.stereotype.Component;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import static alex.lib.Helper.bytesToHex;

@Component("Crypto")
public class Crypto {
    private static final Log log = LogFactory.getLog(Crypto.class);
    private static final String KEY_ALGORITHM = "AES";
    // AES加密算法
    private static final String CIPHER_ALGORITHM = "AES/GCM/NoPadding";
    private static final Charset CHARSET = StandardCharsets.UTF_8;
    private static SecretKeySpec secretKeySpec;

    /**
     * AES 解密操作
     *
     * @param base64Content 待解密BASE64内容
     * @return 解密后的原文
     */
    public static String decrypt(String base64Content) {
        try {
            byte[] content = Base64.getDecoder().decode(base64Content);
            if (content.length < 12 + 16)
                throw new IllegalArgumentException();
            GCMParameterSpec params = new GCMParameterSpec(128, content, 0, 12);
            Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, params);
            byte[] decryptData = cipher.doFinal(content, 12, content.length - 12);
            return new String(decryptData, CHARSET);
        } catch (BadPaddingException e) {
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    /**
     * AES 加密操作
     *
     * @param content 待加密内容
     * @return 返回Base64转码后的加密数据
     */
    public static String encrypt(String content) {
        try {
            byte[] iv = new byte[12];
            SecureRandom secureRandom = new SecureRandom();
            secureRandom.nextBytes(iv);
            byte[] contentBytes = content.getBytes(CHARSET);
            Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
            GCMParameterSpec params = new GCMParameterSpec(128, iv);
            cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, params);
            byte[] encryptData = cipher.doFinal(contentBytes);
            assert encryptData.length == contentBytes.length + 16;
            byte[] message = new byte[12 + contentBytes.length + 16];
            System.arraycopy(iv, 0, message, 0, 12);
            System.arraycopy(encryptData, 0, message, 12, encryptData.length);
            return Base64.getEncoder().encodeToString(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String hash(String algorithm, String data) {
        try {
            byte[] bytes = MessageDigest.getInstance(algorithm).digest(data.getBytes());
            return bytesToHex(bytes);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    @SuppressWarnings("StatementWithEmptyBody")
    public static String hash(String algorithm, InputStream inputStream) {
        try {
            MessageDigest md = MessageDigest.getInstance(algorithm);
            DigestInputStream dis = new DigestInputStream(inputStream, md);
            byte[] buffer = new byte[10240];
            while (dis.read(buffer) > -1) {
            }
            String hash = bytesToHex(dis.getMessageDigest().digest());
            dis.close();
            return hash;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String sha256(String data) {
        return hash("SHA-256", data);
    }

    public static String sha256(InputStream inputStream) {
        return hash("SHA-256", inputStream);
    }

    public static String sha3_256(String data) {
        return hash("SHA3-256", data);
    }

    public static String sha3_256(InputStream inputStream) {
        return hash("SHA3-256", inputStream);
    }

    /**
     * 初始化密钥
     */
    @Autowired
    private void initSecretKey(ConfigurableApplicationContext context) {
        String key = context.getEnvironment().getProperty("application.key");
        if (key == null) {
            log.warn("need config: application.key");
            key = "";
        }
        KeyGenerator kg = null;
        SecureRandom secureRandom = null;
        try {
            kg = KeyGenerator.getInstance(KEY_ALGORITHM);
            // 初始化密钥生成器，AES要求密钥长度为128位、192位、256位
            secureRandom = SecureRandom.getInstance("SHA1PRNG");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return;
        }
        secureRandom.setSeed(key.getBytes());
        kg.init(128, secureRandom);
        SecretKey secretKey = kg.generateKey();
        // AES密钥
        secretKeySpec = new SecretKeySpec(secretKey.getEncoded(), KEY_ALGORITHM);
    }
}
