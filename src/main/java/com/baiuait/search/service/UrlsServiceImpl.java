package com.baiuait.search.service;

import com.baiuait.search.dao.UrlsMapper;
import com.baiuait.search.entity.Urls;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UrlsServiceImpl implements UrlsService{
    @Resource
    private UrlsMapper urlsMapper;

    @Override
    public List<Urls> getUrlsByUserId(Integer userId) {
        return urlsMapper.getUrlsByUserId(userId);
    }

    @Override
    public void addUrl(Urls urls) {
        urlsMapper.addUrl(urls);
    }

    @Override
    public void deleteUrl(Integer id) {
        urlsMapper.deleteUrl(id);
    }
}
