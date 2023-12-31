//
//  Repository.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/08/01.
//

import Foundation
import Alamofire

protocol DefaultRepository {
    /// 오늘의 웹툰
    func requestTodayWebtoon(completion: @escaping (Result<[TodayWebtoonModel]?,CommonAPIError>) -> Void) -> DataRequest?
    
    /// 웹툰 정보 받기
    func requestWebtoonInfo(id: Int, completion: @escaping (Result<WebtoonInfoModel?,CommonAPIError>) -> Void) -> DataRequest?
}

struct Repository: DefaultRepository {
    /// 오늘의 웹툰
    func requestTodayWebtoon(completion: @escaping (Result<[TodayWebtoonModel]?,CommonAPIError>) -> Void) -> DataRequest? {
        let url = APIConstants.todayComicsURL()
        return APIService.shared.requestApi(requestURL: url, requestType: .post,  modelType: [TodayWebtoonModel].self, completion: completion)
    }
    
    /// 웹툰 정보 받기
    func requestWebtoonInfo(id: Int, completion: @escaping (Result<WebtoonInfoModel?,CommonAPIError>) -> Void) -> DataRequest? {
        let url = APIConstants.comicsInfoURL(id: id)
        return APIService.shared.requestApi(requestURL: url, requestType: .post, modelType: WebtoonInfoModel.self, completion: completion)
    }
    
    /// 웹툰 에피소드 정보 받기
    func requestWebtoonEpisode(id: Int, completion: @escaping (Result<[WebtoonEpisodeModel]?,CommonAPIError>) -> Void) -> DataRequest? {
        let url = APIConstants.comicsEpisodeURL(id: id)
        return APIService.shared.requestApi(requestURL: url, requestType: .post, modelType: [WebtoonEpisodeModel].self, completion: completion)
    }
}
