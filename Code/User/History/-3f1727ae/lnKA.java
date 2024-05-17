import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class Main {
    public static void main(String[] args) {
        String s = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2R7nRj0JMouviqMisFYt0F2QnScoofoR7svCcjrQcTUe7tKKweDnSetdz1A+PLNtk7wKJk+SE3tcVB7KQS/WrdsEaE9CBVJ5YmDpqGaLK9qZhAprWuKdnFU8jZ8KjNh8fXyt8UlcO9ABgiGbuyuzXgyQVbzFfOfEqccSNlIBY3s+LtKkwb2k5GI938X/4SCX3v0r2CKlVU5ZLYYuOUzDLNl6KSToZIx5VSAB3VYp1xYurRLRPb2ncwmunb9sJUTnlwypmBCKcwTxhsFVAEvpz75opuMgv8ba9Hs0Q21PChxu98jNPsgIwUn3xmsMUl0rNgBC3MaPs8nSgcT4oUXaVwIDAQAB";

        Base64.Decoder decoder = Base64.getDecoder();
        byte[] decoded = decoder.decode(s);

        System.out.println("Jaja = " + decoded);

        final PublicKey generatePublic = KeyFactory.getInstance("RSA")
                .generatePublic(new X509EncodedKeySpec(Base64.decode(
                        "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2R7nRj0JMouviqMisFYt0F2QnScoofoR7svCcjrQcTUe7tKKweDnSetdz1A+PLNtk7wKJk+SE3tcVB7KQS/WrdsEaE9CBVJ5YmDpqGaLK9qZhAprWuKdnFU8jZ8KjNh8fXyt8UlcO9ABgiGbuyuzXgyQVbzFfOfEqccSNlIBY3s+LtKkwb2k5GI938X/4SCX3v0r2CKlVU5ZLYYuOUzDLNl6KSToZIx5VSAB3VYp1xYurRLRPb2ncwmunb9sJUTnlwypmBCKcwTxhsFVAEvpz75opuMgv8ba9Hs0Q21PChxu98jNPsgIwUn3xmsMUl0rNgBC3MaPs8nSgcT4oUXaVwIDAQAB"
                                .getBytes(StandardCharsets.UTF_8),
                        2)));
        final Cipher instance = Cipher.getInstance("RSA/ECB/PKCS1Padding");
        instance.init(1, generatePublic);
        encodeToString = Base64.encodeToString(instance.doFinal(encodeToString.getBytes(StandardCharsets.UTF_8)), 2);
        return encodeToString;

    }

}
