// Constants.swift
// Copyright © KadyrKZ. All rights reserved.

import CoreGraphics
import Foundation

/// DiagnosisSummaryConstants – локализованные строки для экрана результатов диагностики.
enum DiagnosisSummaryConstants {
    static var viewTitle: String { "Diagnosis Summary".localized() }
    static var nameTextFieldPlaceholder: String { "Enter name to save result".localized() }
    static var warningLabelText: String { "The result may be inaccurate.".localized() }
    static var saveButtonTitle: String { "Save".localized() }
    static var alertTitle: String { "Success".localized() }
    static var alertMessage: String { "Diagnosis saved!".localized() }
    static var alertActionTitle: String { "OK".localized() }
}

/// UserDefaults Keys
enum UserDefaultsKeys {
    static let hasShownOnboarding = "hasShownOnboarding"
}

/// LoadingConstants – локализованные строки для экрана загрузки.
enum LoadingConstants {
    static var message: String { "Please wait.\nDiagnostics takes 1 to 5 minutes.".localized() }
    static var hideButtonTitle: String { "Hide".localized() }
}

/// DiagnosticConstants – локализованные строки для экрана диагностики.
enum DiagnosticConstants {
    static var diagnosticTitle: String { "MindShield".localized() }
    static var instructionsText: String {
        "instructions_text_key".localized()
    }

    static var recordButtonTitle: String { "Record Video".localized() }
    static var galleryButtonTitle: String { "Select Video from Gallery".localized() }
    static var settingsButtonTitle: String { "Settings".localized() }
    static var instructionVideoButtonTitle: String { "Watch Instruction Video".localized() }
    static var cameraUnavailableTitle: String { "Camera Unavailable".localized() }
    static var cameraUnavailableMessage: String { "This device does not support video recording.".localized() }
    static var videoRecordingUnavailableTitle: String { "Video Recording Unavailable".localized() }
    static var videoRecordingUnavailableMessage: String {
        "Video recording is not available on this device.".localized()
    }

    static var galleryUnavailableTitle: String { "Gallery Unavailable".localized() }
    static var galleryUnavailableMessage: String { "Access to the gallery is not available.".localized() }
    // URL не локализуется
    static var serverURL: String { "https://my-flask-app-608127581259.us-central1.run.app/predict" }
    static var startingUploadMessage: String { "Starting video upload: ".localized() }
    static var uploadSuccessMessage: String { "Video upload successful. Server response: ".localized() }
    static var uploadErrorMessage: String { "Video upload error: ".localized() }
}

/// SettingsConstants – локализованные строки для экрана настроек.
enum SettingsConstants {
    static var languageTitle: String { "Chose system language".localized() }
    static var themeTitle: String { "System theme".localized() }
    static let languageItems = ["Kazakh", "Russian", "English"]
    static let languageCodes = ["kk", "ru", "en"]
    static let themeItems = ["Light", "Dark"]
    static var doneButtonTitle: String { "Done".localized() }

    static let selectedLanguageKey = "selectedLanguageIndex"
    static let selectedThemeKey = "selectedThemeIndex"
}

/// HistoryConstants – локализованные строки для экрана истории.
enum HistoryConstants {
    static var clearButtonTitle: String { "Clear".localized() }
    static var probabilityPrefix: String { "Probability: ".localized() }
    static var diagnosisPrefix: String { "Diagnosis: ".localized() }
}

/// OnboardingConstants – локализованные строки для экрана онбординга.
enum OnboardingConstants {
    static var welcomeTitle: String { "Welcome to Cognitive Diagnostics".localized() }
    static var descriptionText: String {
        """
        This app is designed for diagnosing cognitive impairments,
        such as Alzheimer's and Parkinson's disease.
        You can record a video of your gait and get a preliminary result
        expressed in percentage.
        """.localized()
    }

    static var instructionsText: String {
        """
        Instructions:
        1. Tap "Record Video" to record.
        2. Follow recommendations (lighting, angle).
        3. Wait for diagnosis results.
        """.localized()
    }

    static var disclaimerText: String {
        """
        Disclaimer: This app does not replace a doctor's consultation.
        The results are preliminary and for informational purposes only.
        """.localized()
    }

    static var continueButtonTitle: String { "Start".localized() }
}

/// TrainingDetailConstants – константы для экрана деталей тренировки.
enum TrainingDetailConstants {
    static let videoHeight: CGFloat = 300
    static let sidePadding: CGFloat = 16
}

/// TrainingConstants – локализованные строки для экрана тренировки.
enum TrainingConstants {
    static let collectionSpacing: CGFloat = 10
    static let headerHeight: CGFloat = 40
    static var title: String { "Training".localized() }
}
