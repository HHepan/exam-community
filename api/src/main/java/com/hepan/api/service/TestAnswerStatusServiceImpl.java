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
import java.util.Objects;

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
        testAnswerStatusList.forEach(item -> {
            if (Objects.equals(item.getQuestion().getOptions(), "")) {
                String analysis = this.answerBaiduApi(item.getQuestion().getStem(), item.getCorrectAnswer(), item.getAdUserAnswer());
                item.setAnalysis(analysis);
            }
        });
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
    public String answerBaiduApi(String stem, String correctAnswer, String answer) {
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


        return this.getAnswerFromBaiduChat(accessToken, stem, correctAnswer, answer);
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


        return ResponseEntity.ok(response.getBody());
    }

    private String getAnswerFromBaiduChat(String access_token, String stem, String correctAnswer, String answer) {
        String url = "https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions?access_token=" + access_token;

        String requestBody = "{\n" +
                "   \"messages\": [\n" +
                "    {\"role\":\"user\",\"content\":\"" +
                "Question stem:" + stem + ";" +
                "correct answer:" + correctAnswer + ";" +
                "my answer:" + answer + ";" +
                "Is my answer correct? If it is correct, please only reply 1; if it is incorrect, please do an analysis of the wrong question.Please reply in Chinese and limit the length of your answer to 255 characters." +
                "\"}\n" +
                "   ]\n" +
                "}";

        RestTemplate restTemplate = new RestTemplate();
        String response = restTemplate.postForObject(url, requestBody, String.class);

        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = null;
        try {
            jsonNode = objectMapper.readTree(response);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        String result = jsonNode.get("result").asText();

        return result;
    }
}
