# classes.dex

.class public Lcom/android/quickstep/QuickstepProcessInitializer;
.super Lcom/android/launcher3/MainProcessInitializer;
.source "QuickstepProcessInitializer.java"


# static fields
.field private static final SETUP_DELAY_MILLIS:I = 0x1388

.field private static final TAG:Ljava/lang/String; = "QuickstepProcessInitializer"


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 2

    .line 37
    invoke-direct {p0}, Lcom/android/launcher3/MainProcessInitializer;-><init>()V

    .line 40
    const/4 p1, -0x1

    invoke-static {p1}, Lcom/android/systemui/shared/system/InteractionJankMonitorWrapper;->cancel(I)V

    .line 41
    return-void
.end method


# virtual methods
.method protected init(Landroid/content/Context;)V
    .registers 5

    .line 48
    const-string v0, "user"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/UserManager;

    .line 49
    invoke-virtual {v0}, Landroid/os/UserManager;->isManagedProfile()Z

    move-result v0

    if-eqz v0, :cond_23

    .line 50
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 51
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x2

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/pm/PackageManager;->setApplicationEnabledSetting(Ljava/lang/String;II)V

    .line 53
    const-string p1, "QuickstepProcessInitializer"

    const-string v0, "Disabling com.android.launcher3, unable to run in a managed profile"

    invoke-static {p1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 55
    return-void

    .line 58
    :cond_23
    invoke-super {p0, p1}, Lcom/android/launcher3/MainProcessInitializer;->init(Landroid/content/Context;)V

    .line 61
    sget p1, Landroid/view/ThreadedRenderer;->EGL_CONTEXT_PRIORITY_HIGH_IMG:I

    invoke-static {p1}, Landroid/view/ThreadedRenderer;->setContextPriority(I)V

    .line 63
    return-void
.end method
