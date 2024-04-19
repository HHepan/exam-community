package com.hepan.api.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hepan.api.entity.TestAnswerStatus;
import com.hepan.api.repository.TestAnswerStatusRepository;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

@Service
public class TestAnswerStatusServiceImpl implements TestAnswerStatusService {
    String API_Key = "tCeRYiIhwPlB8gkjOcU26B5r";

    String Secret_Key = "124LjWNOrg8C3aKRbubIGTyo8cc8mBoq";

    private TestAnswerStatusRepository testAnswerStatusRepository;
    TestAnswerStatusServiceImpl(TestAnswerStatusRepository testAnswerStatusRepository) {
        this.testAnswerStatusRepository = testAnswerStatusRepository;
    }

    @Override
    public void save(List<TestAnswerStatus> testAnswerStatusList) {
        this.testAnswerStatusRepository.saveAll(testAnswerStatusList);
    }

    @Override
    public Iterable<TestAnswerStatus> getListTestAnswerStatusByAdUserId(Long adUserId) {
        return this.testAnswerStatusRepository.findAllByAdUserId(adUserId);
    }

    @Override
    public Iterable<TestAnswerStatus> getTestAnswerStatusListByTestId(Long id) {
        return this.testAnswerStatusRepository.findAllByTestId(id);
    }

    @Override
    public void testBaiduApi() {
        ResponseEntity<String> a = this.getAccessToken();
        String responseBody = a.getBody();

        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = null;
        try {
            jsonNode = objectMapper.readTree(responseBody);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        String accessToken = jsonNode.get("access_token").asText();

        System.out.println(accessToken);

        this.getAnswerFromBaiduChat(accessToken);
    }

    private ResponseEntity<String> getAccessToken() {
        // 设置请求的URL
        String url = "https://aip.baidubce.com/oauth/2.0/token?client_id=" + API_Key + "&client_secret=" + Secret_Key + "&grant_type=client_credentials";

        // 设置请求的Payload
        String payload = "{}";

        // 设置请求的Headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));

        // 发起POST请求
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(url, new HttpEntity<>(payload, headers), String.class);

        System.out.println(ResponseEntity.ok(response.getBody()));

        return ResponseEntity.ok(response.getBody());
    }

    private void getAnswerFromBaiduChat(String access_token) {
        String url = "https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions?access_token=" + access_token;

        String requestBody = "{\n" +
                "   \"messages\": [\n" +
                "    {\"role\":\"user\",\"content\":\"" +
                "hello" +
                "\"}\n" +
                "   ]\n" +
                "}";

        RestTemplate restTemplate = new RestTemplate();
        String response = restTemplate.postForObject(url, requestBody, String.class);

        System.out.println("getAnswerFromBaiduChat:" + response);
    }
}
