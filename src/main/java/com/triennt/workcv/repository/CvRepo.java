package com.triennt.workcv.repository;

import com.triennt.workcv.entity.Cv;
import com.triennt.workcv.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CvRepo extends JpaRepository<Cv, Integer> {
    Cv getByUser(User user);
    void deleteByFilePath(String filePathCv);
    Cv getByFilePath(String filePath);
}
