const express = require('express');
const bodyParser = require('body-parser');
const app = express();

// 使用 body-parser 中間件來解析 URL 編碼的表單數據
app.use(bodyParser.urlencoded({ extended: false }));
// 使用 body-parser 中間件來解析 JSON 格式的請求主體
app.use(bodyParser.json());

// 學生已選課程的示例數據，實際應用中可能需要從數據庫中獲取這些數據
let selectedCourses = [
    { id: '1', name: '課程1', department: '系所A', credits: 3 },
    { id: '2', name: '課程2', department: '系所B', credits: 4 },
    // 更多的已選課程...
];

// 學生的課程數據，這裡只是一個示例，實際應用中可能需要從數據庫中獲取這些數據
let courses = [
    { id: '1', name: '課程1', teacher: '教師1', time: '時間1', credits: 3, compulsory: false },
    { id: '2', name: '必修課程', teacher: '教師2', time: '時間2', credits: 4, compulsory: true },
    // 更多的課程...
];

// 最低學分限制
const minCredits = 9;
// 最高學分限制
const maxCredits = 30;

// 處理退選課程的 POST 請求
app.post('/drop-course', function(req, res) {
    const courseId = req.body['course-id'];

    // 找到要退選的課程
    const course = courses.find(course => course.id === courseId);

    if (!course) {
        return res.status(404).json({ success: false, message: '找不到指定的課程，請確認課程編號是否正確。' });
    }

    const creditsToDrop = course.credits;

    // 檢查退選後學分是否低於最低學分限制
    const remainingCredits = calculateRemainingCredits(creditsToDrop);
    if (remainingCredits < minCredits) {
        return res.status(400).json({ success: false, message: `退選後學分不可低於最低學分限制 (${minCredits} 學分)！` });
    }

    // 檢查是否退選必修課
    if (course.compulsory) {
        // 如果是必修課，則返回警告
        return res.status(200).json({ success: true, warning: '你確定要退選這門必修課嗎？' });
    }

    // 從課程列表中刪除課程
    courses = courses.filter(course => course.id !== courseId);

    res.status(200).json({ success: true, creditsToDrop: creditsToDrop });
});

// 處理加選課程的 POST 請求
app.post('/add-course', function(req, res) {
    const { courseId, courseName, courseDepartment, courseCredits } = req.body;

    // 檢查是否已選相同名稱的課程
    const hasDuplicate = selectedCourses.some(course => course.name === courseName);
    if (hasDuplicate) {
        return res.status(400).json({ success: false, message: '不能加選與已選課程同名的課程。' });
    }

    // 檢查加選限制，例如課程是否屬於本系（系所）
    if (courseDepartment !== '本系') {
        return res.status(400).json({ success: false, message: '只能加選本系的課程。' });
    }

    // 假設沒有時間衝突的檢查

    // 檢查學分是否超過最高學分限制
    const currentCredits = selectedCourses.reduce((totalCredits, course) => totalCredits + course.credits, 0);
    if (currentCredits + courseCredits > maxCredits) {
        return res.status(400).json({ success: false, message: `加選後學分不可超過最高學分限制 (${maxCredits} 學分)。` });
    }

    // 如果所有檢查通過，將新加選的課程信息加入已選課程列表
    selectedCourses.push({ id: courseId, name: courseName, department: courseDepartment, credits: courseCredits });

    res.status(200).json({ success: true, message: '加選成功！' });
});

// 處理課程篩選的 GET 請求
app.get('/filter-courses', function(req, res) {
    const { department, type, courseCode, courseName, teacher, time } = req.query;

    // 篩選符合條件的課程
    const filteredCourses = courses.filter(course => {
        return (department === '全部' || course.department === department) &&
            (type === '全部' || (type === '必修' && course.compulsory) || (type === '選修' && !course.compulsory)) &&
            (!courseCode || course.id.includes(courseCode)) &&
            (!courseName || course.name.includes(courseName)) &&
            (!teacher || course.teacher.includes(teacher)) &&
            (!time || course.time.includes(time));
    });

    res.status(200).json(filteredCourses);
});

// 處理更新課程資訊的 POST 請求
app.post('/update-course', function(req, res) {
    const { courseId, newName, newCredits } = req.body;

    // 找到要更新的課程
    const courseToUpdate = selectedCourses.find(course => course.id === courseId);

    if (!courseToUpdate) {
        return res.status(404).json({ success: false, message: '找不到指定的課程。' });
    }

    // 更新課程名稱和學分數
    if (newName) {
        courseToUpdate.name = newName;
    }
    if (newCredits) {
        courseToUpdate.credits = newCredits;
    }

    res.status(200).json({ success: true, message: '課程資訊更新成功！', course: courseToUpdate });
});

// 獲取已選課程列表的 GET 請求
app.get('/selected-courses', function(req, res) {
    res.status(200).json(selectedCourses);
});

// 計算退選後剩餘學分
function calculateRemainingCredits(creditsToDrop) {
    const currentCredits = selectedCourses.reduce((totalCredits, course) => totalCredits + course.credits, 0);
    return currentCredits - creditsToDrop;
}

// 啟動服務器，監聽指定端口
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`App is listening on port ${PORT}`);
});
