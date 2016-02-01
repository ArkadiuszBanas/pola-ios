//
// Created by Paweł on 26/10/15.
// Copyright (c) 2015 PJMS. All rights reserved.
//

#import <Objection/JSObjection.h>
#import "BPAboutViewController.h"
#import "BPWebAboutRow.h"
#import "BPAnalyticsHelper.h"
#import "BPDeviceHelper.h"
#import "BPTheme.h"
#import "BPAboutViewCell.h"

NSString *const ABOUT_APP_STORE_APP_URL = @"itms-apps://itunes.apple.com/app/id1038401148";
NSString *const ABOUT_FACEBOOK_URL = @"https://www.facebook.com/app.pola";
NSString *const ABOUT_TWITTER_URL = @"https://twitter.com/pola_app";
NSString *const ABOUT_MAIL = @"kontakt@pola-app.pl";


@interface BPAboutViewController ()
@property(nonatomic, readonly) NSArray *rowList;
@end

@implementation BPAboutViewController
- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {

    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Info", @"Info");

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[[UIImage imageNamed:@"CloseIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    closeButton.tintColor = [BPTheme defaultTextColor];
    [closeButton addTarget:self action:@selector(didTapCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [BPTheme lightBackgroundColor];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;


    _rowList = [self createRowList];
}

- (NSArray *)createRowList {
    NSMutableArray *rowList = [NSMutableArray array];
    [rowList addObject:
            [BPWebAboutRow rowWithTitle:NSLocalizedString(@"About Pola application", @"O aplikacji Pola") action:@selector(didTapWebRow:) url:@"https://www.pola-app.pl/m/about" analyticsName:@"O aplikacji Pola"]
    ];
    [rowList addObject:
            [BPWebAboutRow rowWithTitle:NSLocalizedString(@"InstructionSet", @"Metodologia") action:@selector(didTapWebRow:) url:@"https://www.pola-app.pl/m/method" analyticsName:@"Metodologia"]
    ];
    [rowList addObject:
            [BPWebAboutRow rowWithTitle:NSLocalizedString(@"About KJ", @"O Klubie Jagiellońskim") action:@selector(didTapWebRow:) url:@"https://www.pola-app.pl/m/kj" analyticsName:@"O Klubie Jagiellońskim"]
    ];
    [rowList addObject:
            [BPWebAboutRow rowWithTitle:NSLocalizedString(@"Team", @"Zespół") action:@selector(didTapWebRow:) url:@"https://www.pola-app.pl/m/team" analyticsName:@"Zespół"]
    ];
    [rowList addObject:
            [BPWebAboutRow rowWithTitle:NSLocalizedString(@"Partners", @"Partnerzy") action:@selector(didTapWebRow:) url:@"https://www.pola-app.pl/m/partners" analyticsName:@"Partnerzy"]
    ];
    [rowList addObject:
            [BPAboutRow rowWithTitle:NSLocalizedString(@"Report error in data", @"Zgłoś błąd w danych") action:@selector(didTapReportError:)]
    ];
    if ([MFMailComposeViewController canSendMail]) {
        [rowList addObject:
                [BPAboutRow rowWithTitle:NSLocalizedString(@"Write to us", @"Napisz do nas") action:@selector(didTapWriteToUs:)]
        ];
    }
    [rowList addObject:
            [BPAboutRow rowWithTitle:NSLocalizedString(@"Rate us", @"Oceń nas") action:@selector(didTapRateUs:)]
    ];
    [rowList addObject:
            [BPAboutRow rowWithTitle:NSLocalizedString(@"Pola on Facebook", @"Pola na Feacbooku") action:@selector(didTapFacebook:)]
    ];
    [rowList addObject:
            [BPAboutRow rowWithTitle:NSLocalizedString(@"Pola on Twitter", @"Pola na Twitterze") action:@selector(didTapTwitter:)]
    ];
    return rowList;
}

- (void)didTapCloseButton:(UIButton *)button {
    [self.delegate closeAboutViewController:self];
}

- (void)didTapReportError:(BPAboutRow *)row {
    [BPAnalyticsHelper aboutOpened:@"Zgłoś błąd w danych"];


    JSObjectionInjector *injector = [JSObjection defaultInjector];
    BPReportProblemViewController *reportProblemViewController = [injector getObject:[BPReportProblemViewController class]];
    reportProblemViewController.delegate = self;
    [self presentViewController:reportProblemViewController animated:YES completion:nil];
}

- (void)didTapTwitter:(BPAboutRow *)row {
    [BPAnalyticsHelper aboutOpened:@"Pola na Twitterze"];
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:ABOUT_TWITTER_URL]];
}

- (void)didTapFacebook:(BPAboutRow *)row {
    [BPAnalyticsHelper aboutOpened:@"Pola na Facebooku"];
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:ABOUT_FACEBOOK_URL]];
}

- (void)didTapRateUs:(BPAboutRow *)row {
    [BPAnalyticsHelper aboutOpened:@"Oceń Polę"];
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:ABOUT_APP_STORE_APP_URL]];
}

- (void)didTapWriteToUs:(BPAboutRow *)row {
    [BPAnalyticsHelper aboutOpened:@"Napisz do nas"];

    MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
    composeViewController.delegate = self;
    [composeViewController setMailComposeDelegate:self];
    [composeViewController setToRecipients:@[ABOUT_MAIL]];
    [composeViewController setSubject:NSLocalizedString(@"mail_title", @"")];
    [composeViewController setMessageBody:[BPDeviceHelper deviceInfo] isHTML:NO];
    [self presentViewController:composeViewController animated:YES completion:nil];
}

- (void)didTapWebRow:(BPWebAboutRow *)row {
    [BPAnalyticsHelper aboutOpened:row.analyticsName];
    [self.delegate showWebWithUrl:row.url title:row.title];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rowList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *const identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    BPAboutRow *infoRow = self.rowList[(NSUInteger) indexPath.section];

    cell.textLabel.text = infoRow.title;

    return cell;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BPAboutRow *infoRow = self.rowList[(NSUInteger) indexPath.row];
    [self performSelector:infoRow.action withObject:infoRow];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma clang diagnostic pop

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - BPReportProblemViewControllerDelegate

- (void)reportProblemWantsDismiss:(BPReportProblemViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reportProblem:(BPReportProblemViewController *)controller finishedWithResult:(BOOL)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end