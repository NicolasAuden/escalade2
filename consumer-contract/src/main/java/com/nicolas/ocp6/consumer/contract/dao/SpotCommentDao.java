package com.nicolas.ocp6.consumer.contract.dao;

import com.nicolas.ocp6.model.bean.SpotComment;

import java.util.List;

public interface SpotCommentDao {

    List<SpotComment> findCommentSpotBySpotId(int spotId);

    SpotComment insertSpotComment(SpotComment spotComment);

    void deleteComment(int CommentId);

}
